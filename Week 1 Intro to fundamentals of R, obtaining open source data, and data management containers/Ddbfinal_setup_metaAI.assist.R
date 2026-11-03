#setwd("/Users/md/Library/CloudStorage/OneDrive-TheCityUniversityofNewYork/02brandeis/Brandeis Fall26/RBIF111-Bioinformatics/Week 1 Intro to fundamentals of R, obtaining open source data, and data management containers")
#getwd()
#step 1

install.packages("remotes")
remotes::install_github("brendangongol/repoquet", force = TRUE, build_vignettes = TRUE)
library(repoquet)

#step#2 turn off overwrite if not running for the first time
public_example <- generate_real_world_repository(
  dir = file.path(getwd(), "repoquet_public_example"),
  profile = c("comprehensive"),
  IncludeLarge = NULL,
  Download = FALSE,
  overwrite =FALSE
)

public_example

#Step 3 — Set up database directories + preflight check

cfg <- load_repository_config(public_example$ConfigPath)
paths <- RepositoryInitialize(cfg$FormattedDBPath)
RunId <- new_repository_run_id()

# Review DBSetup.xlsx, then materialize its declared sources:
MDT <- openxlsx::read.xlsx(public_example$MDTPath, sheet = "Sheet1")

ValidateMDTPreflight(
  MDT = MDT, strict = TRUE, logStatus = TRUE,
  ParquetBasePath = paths$ParquetBasePath,
  MaxFileStemTruncate = TRUE,
  TerminalHivePartition = FALSE,
  MasterDBPath = cfg$MasterDBPath,
  LogPath = paths$LogPath, RunId = RunId
)


#------------------
# base <- file.path(getwd(), "repoquet_public_example")
# 
# list.files(base)
# 
# all_files <- list.files(base, recursive = TRUE)
# length(all_files)
# 
# # Downloaded sources?
# sum(grepl("SourceCache", all_files))
# 
# # Actually loaded as Parquet?
# sum(grepl("\\.parquet$", all_files, ignore.case = TRUE))
# 
# # Load / schema artifacts from the document?
# all_files[grepl("checkpoint|RepositoryMetadata|SchemaReview|TableSchemas|\\.duckdb$",
#                 all_files, ignore.case = TRUE)]
# 
# 
# 
# #...
# 
# list.files(file.path(base, "formatted"))
# 
# parquet_files <- all_files[grepl("\\.parquet$", all_files, ignore.case = TRUE)]
# head(parquet_files, 20)
# sum(grepl("SourceCache", parquet_files))
# 
# all2 <- list.files(base, recursive = TRUE, all.files = TRUE, no.. = TRUE)
# all2[grepl("checkpoint|manifest|tableschema|schema", all2, ignore.case = TRUE)]
# 
# 
# 
# #.....
# 
# base <- file.path(getwd(), "repoquet_public_example")
# fmt  <- file.path(base, "formatted")
# 
# count_dir <- function(d) length(list.files(file.path(fmt, d),
#                                            recursive = TRUE,
#                                            all.files = TRUE, no.. = TRUE))
# 
# c(Checkpoints = count_dir("Checkpoints"),
#   Manifest    = count_dir("Manifest"),
#   parquet     = count_dir("parquet"),
#   Schema      = count_dir("Schema"),
#   SourceCache = count_dir("SourceCache"),
#   Logs        = count_dir("Logs"))
# 
# list.files(file.path(fmt, "Schema"))
# list.files(file.path(fmt, "Manifest"))
# list.files(file.path(fmt, "Checkpoints"))
# head(list.files(file.path(fmt, "parquet"), recursive = TRUE), 20)













#3.update

library(repoquet)

base <- file.path(getwd(), "repoquet_public_example")

public_example <- list(
  ConfigPath = file.path(base, "repository_config.R"),
  MDTPath    = file.path(base, "DBSetup.xlsx")
)

cfg   <- load_repository_config(public_example$ConfigPath)
paths <- RepositoryInitialize(cfg$FormattedDBPath)
RunId <- new_repository_run_id()

MDT <- openxlsx::read.xlsx(public_example$MDTPath, sheet = "Sheet1")

ValidateMDTPreflight(
  MDT = MDT, strict = TRUE, logStatus = TRUE,
  ParquetBasePath = paths$ParquetBasePath,
  MaxFileStemTruncate = TRUE,
  TerminalHivePartition = FALSE,
  MasterDBPath = cfg$MasterDBPath,
  LogPath = paths$LogPath, RunId = RunId
)

dim(MDT)
sort(unique(MDT$Database))

#step 3. update2

MDT <- MaterializeRemoteSources(
  MDT = MDT,
  DownloadCachePath = paths$DownloadCachePath,
  Offline = isTRUE(cfg$RemoteOffline),
  DefaultDownloadPolicy = cfg$DownloadPolicy %||% "if_missing",
  TimeoutSeconds = cfg$DownloadTimeout %||% 10800,
  Strict = FALSE,
  LogPath = paths$LogPath,
  RunId = RunId
)

failed <- MDT[MDT$RemoteCacheStatus == "failed", ]
MDT <- MDT[MDT$RemoteCacheStatus != "failed", ]

pending <- MDTCompleteStatus(
  MDT = MDT, CheckpointPath = paths$CheckpointPath,
  verbose = TRUE, logStatus = TRUE,
  MasterDBPath = cfg$MasterDBPath,
  SourceFingerprintMode = cfg$SourceFingerprintMode
)

nrow(failed)
dim(MDT)

#---res

table(failed$Database)

failed[, intersect(c("Database", "TableName"), names(failed)), drop = FALSE]



#........

schema_issues <- GetSchemaObservations(
  ObservationPath = paths$SchemaObservationPath,
  IssuesOnly = TRUE, Limit = 100L
)
nrow(schema_issues)
if (nrow(schema_issues) > 0L) print(schema_issues)

paths$SchemaReviewPath
#.....fin

repository_catalog <- FinalizeSchemaRegistry(
  SchemaReviewPath = paths$SchemaReviewPath,
  TableSchemaPath  = paths$TableSchemaPath,
  strict = TRUE
)

file.exists(paths$TableSchemaPath)
paths$TableSchemaPath

#..........

DBLoad <- sort(unique(MDT$Database))
DBLoad

result <- ParquetBackEndCreate(
  MDT = MDT,
  DBLoad = DBLoad,
  MasterDBPath = cfg$MasterDBPath,
  completed_checkpoint = load_checkpoint(paths$CheckpointPath),
  CheckpointPath = paths$CheckpointPath,
  ParquetBasePath = paths$ParquetBasePath,
  LogPath = paths$LogPath,
  n_workers = cfg$n_workers,
  PartitionBy = cfg$PartitionBy,
  RAMThreshold = cfg$RAMThreshold,
  SAV_ROW_THRESHOLD = cfg$SAV_ROW_THRESHOLD,
  SAV_CHUNK_SIZE = cfg$SAV_CHUNK_SIZE,
  MaxFileStemTruncate = TRUE,
  TerminalHivePartition = FALSE,
  SchemaRegistryPath = paths$SchemaRegistryPath,
  TableSchemaPath = paths$TableSchemaPath,
  ManifestPath = paths$ManifestPath,
  MetadataWorkbookPath = paths$ManifestWorkbookPath,
  UseSchemaCatalog = TRUE,
  StrictPreflight = TRUE,
  StrictSchemaValidation = TRUE,
  RunPreflight = FALSE,
  DownloadCachePath = paths$DownloadCachePath,
  MaterializeRemote = FALSE,
  SourceFingerprintMode = cfg$SourceFingerprintMode,
  MaxCoerceNAPct = cfg$MaxCoerceNAPct,
  AutoCleanup = TRUE,
  CleanupAfterPhase = "database",
  StopOnFileError = TRUE,
  ReturnRunResult = TRUE,
  RunId = RunId
)
print(result)

#--------------

SummaryVerification(
  MDT = MDT,
  CheckpointPath = paths$CheckpointPath,
  LogPath = paths$LogPath,
  logStatus = FALSE,
  RunId = RunId,
  MasterDBPath = cfg$MasterDBPath,
  SourceFingerprintMode = cfg$SourceFingerprintMode
)

#---------
ExportRepositoryMetadata(paths$ManifestPath, paths$ManifestWorkbookPath)
#

# Find a real UCI Database/TableName pair from the inventory
uci_rows_preview <- MDT[grepl("uci", MDT$Database, ignore.case = TRUE), ]
example_db       <- unique(uci_rows_preview$Database)[1]
example_table    <- unique(uci_rows_preview$TableName)[1]

# See which columns of that table have recorded schema observations
table_observations <- GetSchemaObservations(
  paths$SchemaObservationPath,
  Database = example_db,
  TableName = example_table
)
example_column <- unique(table_observations$Column)[1]

# Targeted lookup: pull just the observations for that one Database/TableName/Column
Observations <- GetSchemaObservations(
  paths$SchemaObservationPath,
  Database = example_db,
  TableName = example_table,
  Column = example_column
)
Observations[, 1:9]

#---------------


public_example <- generate_real_world_repository(
  dir = file.path(getwd(), "repoquet_public_example"),
  profile = c("comprehensive"),
  IncludeLarge = NULL, Download = FALSE, overwrite = TRUE)
#--------

# --- SALVAGE SUBSTITUTION for the document's first line only ---
public_example <- list(
  ConfigPath = file.path(getwd(), "repoquet_public_example", "repository_config.R"),
  MDTPath    = file.path(getwd(), "repoquet_public_example", "DBSetup.xlsx")
)
# --- Everything below is the document's block, verbatim ---

cfg   <- load_repository_config(public_example$ConfigPath)
paths <- RepositoryInitialize(cfg$FormattedDBPath)
RunId <- new_repository_run_id()
MDT   <- openxlsx::read.xlsx(public_example$MDTPath, sheet = "Sheet1")

MDT <- MaterializeRemoteSources(
  MDT = MDT,
  DownloadCachePath = paths$DownloadCachePath,
  Offline = isTRUE(cfg$RemoteOffline),
  DefaultDownloadPolicy = cfg$DownloadPolicy %||% "if_missing",
  TimeoutSeconds = cfg$DownloadTimeout %||% 10800,
  Strict = FALSE,
  LogPath = paths$LogPath, RunId = RunId
)
failed <- MDT[MDT$RemoteCacheStatus == "failed", ]
MDT    <- MDT[MDT$RemoteCacheStatus != "failed", ]

TempDirPath <- file.path(cfg$FormattedDBPath, "duckdb_temp")
dir.create(TempDirPath, recursive = TRUE, showWarnings = FALSE)

con <- open_duckdb(
  FormattedDBPath = cfg$FormattedDBPath,
  DBName = cfg$DBName,
  TempDirPath = TempDirPath,
  GB = cfg$DuckDB_GB,
  ReadOnly = FALSE
)

completed_checkpoint <- load_checkpoint(paths$CheckpointPath)

done <- MDT[checkpoint_completed_mask(
  MDT,
  completed_checkpoint,
  MasterDBPath = cfg$MasterDBPath,
  SourceFingerprintMode = cfg$SourceFingerprintMode
), ]

if (nrow(done) == 0L && nrow(MDT) > 0L) {
  probe_row      <- MDT[1L, , drop = FALSE]
  computed_key   <- repository_checkpoint_key(
    probe_row,
    MasterDBPath = cfg$MasterDBPath,
    SourceFingerprintMode = cfg$SourceFingerprintMode
  )
  closest_stored <- grep(
    paste0("^", probe_row$Database, "\\|\\|", probe_row$TableName, "\\|\\|"),
    completed_checkpoint, value = TRUE
  )
  cat("Computed key for this MDT row:\n  ", computed_key, "\n\n", sep = "")
  cat("Closest stored checkpoint entr",
      if (length(closest_stored) == 1L) "y" else "ies",
      " for the same Database/TableName:\n", sep = "")
  print(closest_stored)
}

nrow(done)
length(unique(repository_table_names(done)))

#----------

register_parquet_view_compile(
  con = con,
  ParquetBasePath = paths$ParquetBasePath,
  tables_written = unique(repository_table_names(done)),
  TableSchemaPath = paths$TableSchemaPath,
  SchemaRegistryPath = paths$SchemaRegistryPath,
  validate = TRUE,
  strict_validation = TRUE,
  LogPath = paths$LogPath,
  RunId = RunId
)

contract_results <- validate_data_contracts(
  con = con,
  DataContractPath = paths$DataContractPath,
  strict = TRUE,
  LogPath = paths$LogPath,
  RunId = RunId
)
contract_results

#-------------

if (exists("con") && DBI::dbIsValid(con)) {
  DBI::dbDisconnect(con, shutdown = TRUE)
}

con <- open_duckdb(
  FormattedDBPath = cfg$FormattedDBPath,
  DBName = cfg$DBName,
  TempDirPath = TempDirPath,
  GB = cfg$DuckDB_GB,
  ReadOnly = TRUE
)

sort(unique(MDT$Database))

tables <- DBViewSummary(
  con = con,
  verbose = TRUE,
  logStatus = FALSE
)

#---------

uci_rows <- MDT[grepl("uci", MDT$Database, ignore.case = TRUE), ]
uci_tables <- unique(repository_table_names(uci_rows))
uci_tables <- uci_tables[uci_tables %in% DBI::dbListTables(con)]
head(uci_tables, 10)

first_uci_table <- uci_tables[1]
first_uci_table

DBI::dbGetQuery(
  con,
  paste0("DESCRIBE ", first_uci_table)
)

top5_uci <- DBI::dbGetQuery(
  con,
  paste0("SELECT * FROM ", first_uci_table, " LIMIT 5")
)

datatable(top5_uci, options = list(scrollX = TRUE))



dim(top5_uci)

DT::datatable(
  top5_uci,
  options = list(scrollX = TRUE)
)





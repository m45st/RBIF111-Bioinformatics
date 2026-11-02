#### Repository loader. Run top to bottom, or step through interactively. ####
#### All machine-specific settings live in repository_config.R. ##############
library(data.table); library(openxlsx); library(DBI); library(duckdb)
library(haven); library(arrow); library(glue); library(future); library(future.apply)

source("<PATH TO REPOQUET CLONE>/R/repoquet.R")   # development mode

#### Initialize paths, configuration, and one traceable run identifier #######
#### Pass RunId through every stage so logs and validation records align. ####
cfg <- load_repository_config("/Users/md/Library/CloudStorage/OneDrive-TheCityUniversityofNewYork/02brandeis/Brandeis Fall26/RBIF111-Bioinformatics/Week 1 Intro to fundamentals of R, obtaining open source data, and data management containers/repoquet_public_example/repository_config.R")
paths <- RepositoryInitialize(FormattedDBPath = cfg$FormattedDBPath)
RunId <- new_repository_run_id()
MDT <- openxlsx::read.xlsx(cfg$MDTPath, sheet = "Sheet1")
DBLoad <- sort(unique(MDT$Database))

#### Fail-fast inventory validation before any repository write ##############
#### Checks readers, remote declarations, partitions, names, and outputs. ####
# scan_for_new_source_files(cfg$MasterDBPath, MDT)   # propose rows for new files
ValidateMDTPreflight(MDT, strict = TRUE, ParquetBasePath = paths$ParquetBasePath,
                     MaxFileStemTruncate = TRUE, TerminalHivePartition = FALSE,
                     MasterDBPath = cfg$MasterDBPath,
                     LogPath = paths$LogPath, RunId = RunId)
#### Resolve optional direct HTTP/HTTPS sources to the managed raw cache. ####
MDT <- MaterializeRemoteSources(MDT, DownloadCachePath = paths$DownloadCachePath,
                                Offline = isTRUE(cfg$RemoteOffline),
                                DefaultDownloadPolicy = cfg$DownloadPolicy %||% "if_missing",
                                TimeoutSeconds = cfg$DownloadTimeout %||% 10800,
                                LogPath = paths$LogPath, RunId = RunId)
pending <- MDTCompleteStatus(MDT, paths$CheckpointPath, verbose = TRUE, logStatus = TRUE)

#### Survey source evidence and write the compact review workbook #############
#### Source files stay read-only; detailed observations remain in Parquet. ####
PrepareSchemaRegistry(MDT, DBLoad = DBLoad, MasterDBPath = cfg$MasterDBPath,
                      ObservationPath = paths$SchemaObservationPath,
                      SchemaReviewPath = paths$SchemaReviewPath,
                      n_workers = cfg$SchemaWorkers,
                      SchemaRegistryPath = paths$SchemaRegistryPath,
                      SourceFingerprintMode = cfg$SourceFingerprintMode,
                      SchemaSurveyMode = cfg$SchemaSurveyMode,
                      FastReadMaxBytes = cfg$SchemaFastReadMaxBytes,
                      SchemaChunkSize = cfg$SchemaChunkSize,
                      AdaptiveSampleRows = cfg$SchemaAdaptiveSampleRows,
                      FutureGlobalsMaxSizeMB = cfg$SchemaFutureGlobalsMaxSizeMB,
                      ReuseObservationCache = cfg$SchemaReuseCache,
                      ValuePreviewMaxDistinct = 15L,
                      ValuePreviewTypes = c("character", "integer", "int64", "logical"),
                      ValuePreviewIdentifiers = FALSE,
                      LogPath = paths$LogPath, RunId = RunId)
# Optional bounded preview; does not load all observations into R.
schema_issues <- GetSchemaObservations(paths$SchemaObservationPath, IssuesOnly = TRUE, Limit = 100L)
if (nrow(schema_issues) > 0L) print(schema_issues)

#### Review StartHere, resolve blocking decisions, and finalize ##############
#### Accept keeps recommendations; Override supplies an approved value. ######
#### Ignore separates unrelated compatibility fields or omits a label.  ######
repository_catalog <- FinalizeSchemaRegistry(SchemaReviewPath = paths$SchemaReviewPath,
                       TableSchemaPath = paths$TableSchemaPath, strict = TRUE)

#### Load reviewed schemas to Hive-partitioned, resumable Parquet ############
#### State files are snapshotted; checkpoints advance only after success. ####
run_result <- ParquetBackEndCreate(MDT = MDT, DBLoad = DBLoad,
                                  MasterDBPath = cfg$MasterDBPath,
                                  completed_checkpoint = load_checkpoint(paths$CheckpointPath),
                                  CheckpointPath = paths$CheckpointPath,
                                  ParquetBasePath = paths$ParquetBasePath,
                                  LogPath = paths$LogPath, n_workers = cfg$n_workers,
                                  PartitionBy = cfg$PartitionBy, RAMThreshold = cfg$RAMThreshold,
                                  SAV_ROW_THRESHOLD = cfg$SAV_ROW_THRESHOLD,
                                  SAV_CHUNK_SIZE = cfg$SAV_CHUNK_SIZE,
                                  DelimitedChunkMaxMB = cfg$DelimitedChunkMaxMB,
                                  DelimitedPartitionMaxMB = cfg$DelimitedPartitionMaxMB,
                                  FailProbeMode = cfg$FailProbeMode,
                                  FailProbeTimeoutSeconds = cfg$FailProbeTimeoutSeconds,
                                  FailProbeSourcePath = cfg$FailProbeSourcePath,
                                  MaxFileStemTruncate = TRUE, TerminalHivePartition = FALSE,
                                  SchemaRegistryPath = paths$SchemaRegistryPath,
                                  TableSchemaPath = paths$TableSchemaPath,
                                  ManifestPath = paths$ManifestPath,
                                  MetadataWorkbookPath = paths$ManifestWorkbookPath,
                                  MaxCoerceNAPct = cfg$MaxCoerceNAPct,
                                  SourceFingerprintMode = cfg$SourceFingerprintMode,
                                  DownloadCachePath = paths$DownloadCachePath,
                                  MaterializeRemote = FALSE, # resolved before schema survey
                                  StopOnFileError = TRUE, ReturnRunResult = TRUE,
                                  UseSchemaCatalog = TRUE, StrictSchemaValidation = TRUE,
                                  AutoCleanup = TRUE, CleanupAfterPhase = "database",
                                  RunId = RunId,
                                  RunPreflight = FALSE)
print(run_result)
SummaryVerification(MDT, paths$CheckpointPath, paths$LogPath, logStatus = FALSE,
                    RunId = RunId, MasterDBPath = cfg$MasterDBPath,
                    SourceFingerprintMode = cfg$SourceFingerprintMode)

#### Register and strictly validate persistent DuckDB views ##################
TempDirPath <- file.path(cfg$FormattedDBPath, "duckdb_temp")
dir.create(TempDirPath, recursive = TRUE, showWarnings = FALSE)
con <- open_duckdb(FormattedDBPath = cfg$FormattedDBPath, DBName = cfg$DBName,
                   TempDirPath = TempDirPath,
                   GB = cfg$DuckDB_GB, ReadOnly = FALSE)
done <- MDT[checkpoint_completed_mask(MDT, run_result$checkpoint,
                                      MasterDBPath = cfg$MasterDBPath,
                                      SourceFingerprintMode = cfg$SourceFingerprintMode), ]
register_parquet_view_compile(con, ParquetBasePath = paths$ParquetBasePath,
                              tables_written = unique(repository_table_names(done)),
                              SchemaRegistryPath = paths$SchemaRegistryPath,
                              TableSchemaPath = paths$TableSchemaPath,
                              validate = TRUE, strict_validation = TRUE,
                              LogPath = paths$LogPath, RunId = RunId)
contract_results <- validate_data_contracts(con, paths$DataContractPath, strict = TRUE,
                                           LogPath = paths$LogPath, RunId = RunId)
DBI::dbDisconnect(con, shutdown = TRUE)
con <- open_duckdb(FormattedDBPath = cfg$FormattedDBPath, DBName = cfg$DBName,
                   TempDirPath = TempDirPath, GB = cfg$DuckDB_GB, ReadOnly = TRUE)

#### 7. Non-destructively reconcile inventory, state, files, and DuckDB ####
repo_audit <- audit_repository(MDT, paths$ParquetBasePath, paths$CheckpointPath,
                               paths$ManifestPath, con = con,
                               LogPath = paths$LogPath, RunId = RunId)
repo_audit$issues
# search_labels("<term>", TableSchemaPath = paths$TableSchemaPath)   # data dictionary
DBI::dbDisconnect(con, shutdown = TRUE)

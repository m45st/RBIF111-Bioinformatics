# ==============================================================================
# DuckDB Setup & Query Guide for RBIF111 Bioinformatics
# Based on: 1-Week1_Notes_Part3_Downloading_data.html (Section 5)
# Date: 2026-11-03
# ==============================================================================

# 1. Load Required Libraries ---------------------------------------------------
suppressPackageStartupMessages({
  library(DBI)
  library(duckdb)
  library(repoquet)
})

cat("=== 1. Package Status ===\n")
cat("DuckDB version :", as.character(packageVersion("duckdb")), "\n")
cat("DBI version    :", as.character(packageVersion("DBI")), "\n")
cat("repoquet version:", as.character(packageVersion("repoquet")), "\n\n")

# 2. Paths and Repository Configuration ----------------------------------------
config_path <- "repoquet_public_example/repository_config.R"

if (!file.exists(config_path)) {
  stop("Configuration file not found: ", config_path)
}

cfg <- load_repository_config(config_path)
temp_dir <- file.path(cfg$FormattedDBPath, "duckdb_temp")
dir.create(temp_dir, recursive = TRUE, showWarnings = FALSE)

# Database file location
db_file <- file.path(cfg$FormattedDBPath, cfg$DBName)
cat("Database file  :", db_file, "\n")
cat("Temp directory :", temp_dir, "\n\n")

# 3. Connect to DuckDB Database ------------------------------------------------
# For analysis, connect in ReadOnly mode (prevents accidental table modifications)
con <- open_duckdb(
  FormattedDBPath = cfg$FormattedDBPath,
  DBName          = cfg$DBName,
  TempDirPath     = temp_dir,
  GB              = cfg$DuckDB_GB,
  ReadOnly        = TRUE
)

# 4. Explore Available Tables / Views ------------------------------------------
cat("=== 2. Available Tables & Views ===\n")
tables <- dbListTables(con)
print(tables)
cat("\n")

# 5. Sample Queries ------------------------------------------------------------

# Query A: UCI Health - Audiology Standardized Dataset
if ("UCI_HEALTH_UCI8_Audiology_Standardized" %in% tables) {
  cat("--- Sample Query A: UCI Audiology Standardized (First 5 Rows) ---\n")
  uci_sample <- dbGetQuery(
    con,
    "SELECT age_gt_60, air, boneAbnormal, identifier, class 
     FROM UCI_HEALTH_UCI8_Audiology_Standardized 
     LIMIT 5"
  )
  print(uci_sample)
  cat("\n")
}

# Query B: MIMIC-III Clinical Demo - Admissions
if ("MIMICIII_DEMO_ADMISSIONS" %in% tables) {
  cat("--- Sample Query B: MIMIC-III Admissions Summary ---\n")
  admissions_summary <- dbGetQuery(
    con,
    "SELECT admission_type, count(*) as count, 
            round(count(*) * 100.0 / sum(count(*)) over(), 1) as pct
     FROM MIMICIII_DEMO_ADMISSIONS 
     GROUP BY admission_type 
     ORDER BY count DESC"
  )
  print(admissions_summary)
  cat("\n")
}

# Query C: ClinVar Gene-Specific Summary
if ("CLINVAR_GeneSpecificSummary" %in% tables) {
  cat("--- Sample Query C: ClinVar Gene-Specific Summary (Top 5 by Submissions) ---\n")
  clinvar_sample <- dbGetQuery(
    con,
    "SELECT \"#Symbol\" as GeneSymbol, GeneID, Total_submissions 
     FROM CLINVAR_GeneSpecificSummary 
     ORDER BY Total_submissions DESC 
     LIMIT 5"
  )
  print(clinvar_sample)
  cat("\n")
}

# Query D: Local SRA Run Table
if ("SraRunTable" %in% tables) {
  cat("--- Sample Query D: SRA Run Table (Sequencing Metrics) ---\n")
  sra_metrics <- dbGetQuery(
    con,
    "SELECT \"Assay Type\" as Assay, count(*) as Samples, 
            round(avg(Bases) / 1e6, 2) as Avg_MBases,
            round(avg(Bytes) / 1e6, 2) as Avg_MBytes
     FROM SraRunTable 
     GROUP BY \"Assay Type\""
  )
  print(sra_metrics)
  cat("\n")
}

# Query E: Ad-hoc Direct Parquet Query (No view registration needed)
obs_parquet <- file.path(cfg$FormattedDBPath, "Schema/SchemaObservations.parquet")
if (file.exists(obs_parquet)) {
  cat("--- Sample Query E: Direct Parquet Scan (Schema Observations by Database) ---\n")
  query_pq <- sprintf(
    "SELECT Database, count(distinct TableName) as TableCount, count(*) as Observations
     FROM read_parquet('%s') 
     GROUP BY Database 
     ORDER BY Observations DESC",
    obs_parquet
  )
  pq_summary <- dbGetQuery(con, query_pq)
  print(pq_summary)
  cat("\n")
}

# 6. Disconnect & Shutdown Engine ----------------------------------------------
dbDisconnect(con, shutdown = TRUE)
cat("=== Database disconnected successfully ===\n")

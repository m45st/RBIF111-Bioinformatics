library(repoquet)

cfg <- load_repository_config("repoquet_public_example/repository_config.R")

con <- open_duckdb(
  FormattedDBPath = cfg$FormattedDBPath,
  DBName = cfg$DBName,
  TempDirPath = file.path(cfg$FormattedDBPath, "duckdb_temp"),
  GB = cfg$DuckDB_GB,
  ReadOnly = TRUE
)

DBI::dbListTables(con)

tables <- DBViewSummary(con = con , verbose = TRUE , logStatus = FALSE)
# 
# DBI::dbGetQuery( conn = con , "DESCRIBE NHANES_AA" )
# DBI::dbGetQuery(con, "SELECT * FROM NHANES_AA
#                 LIMIT 10")


#uci_rows <- MDT[ grepl( "uci" , MDT$)]

sort (DBI::dbListTables(con)   )                      # find tables

mimi <- DBI::dbListTables(con)
uci_tables <- sort(grep("^MIMICIII_", mimi, value = TRUE, ignore.case = TRUE))
head(mimi, 10)

samp <- mimi[10]

data <- DBI::dbGetQuery(con, paste0( "SELECT * FROM ", DBI::dbQuoteIdentifier(con, samp), " LIMIT 10"))



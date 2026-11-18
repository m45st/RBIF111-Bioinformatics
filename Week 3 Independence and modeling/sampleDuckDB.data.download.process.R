library(repoquet)

# 1. Connect read-only to the existing repository
cfg <- load_repository_config(
 # "repoquet_public_example/repository_config.R"
  
  "/Users/md/Library/CloudStorage/OneDrive-TheCityUniversityofNewYork/02brandeis/Brandeis Fall26/RBIF111-Bioinformatics/Week 1 Intro to fundamentals of R, obtaining open source data, and data management containers/repoquet_public_example"
)
paths <- RepositoryInitialize(cfg$FormattedDBPath)

temp_dir <- file.path(cfg$FormattedDBPath, "duckdb_temp")
dir.create(temp_dir, recursive = TRUE, showWarnings = FALSE)

con <- open_duckdb(
  FormattedDBPath = cfg$FormattedDBPath,
  DBName = cfg$DBName,
  TempDirPath = temp_dir,
  GB = cfg$DuckDB_GB,
  ReadOnly = TRUE
)

# 2. Choose the table and variable
chosen_table  <- "NHANES_BMX"  # NHANES Body Measures examination table
chosen_column <- "BMXBMI"      # Body Mass Index, kg/m^2

# 3. Confirm the table actually exists
all_tables <- DBI::dbListTables(con)
stopifnot(chosen_table %in% all_tables)

# 4. Confirm the column exists and is numeric
schema <- DBI::dbGetQuery(
  con,
  paste0("DESCRIBE ", chosen_table)
)

column_row <- schema[
  toupper(schema$column_name) == chosen_column,
  ,
  drop = FALSE
]

stopifnot(nrow(column_row) == 1)

column_type <- column_row$column_type[1]
print(column_row)

is_numeric <- grepl(
  "INT|FLOAT|DOUBLE|DECIMAL|NUMERIC|REAL",
  column_type,
  ignore.case = TRUE
)
stopifnot(is_numeric)

# 5. Pull the confirmed numeric column with SQL
sql <- sprintf(
  'SELECT "%s" FROM "%s" WHERE "%s" IS NOT NULL',
  chosen_column, chosen_table, chosen_column
)

bmi_data <- DBI::dbGetQuery(con, sql)
bmi <- bmi_data[[chosen_column]]

# Checks / preview
stopifnot(is.numeric(bmi))
head(bmi)
summary(bmi)

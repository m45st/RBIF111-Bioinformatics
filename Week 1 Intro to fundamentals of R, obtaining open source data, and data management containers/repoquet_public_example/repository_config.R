#### Repository configuration -- the only file with machine-specific paths. ####
repository_config <- list(
  MasterDBPath    = "/Users/md/Library/CloudStorage/OneDrive-TheCityUniversityofNewYork/02brandeis/Brandeis Fall26/RBIF111-Bioinformatics/Week 1 Intro to fundamentals of R, obtaining open source data, and data management containers/repoquet_public_example/source_data",   # root of the source data files
  FormattedDBPath = "/Users/md/Library/CloudStorage/OneDrive-TheCityUniversityofNewYork/02brandeis/Brandeis Fall26/RBIF111-Bioinformatics/Week 1 Intro to fundamentals of R, obtaining open source data, and data management containers/repoquet_public_example/formatted",   # parquet store, checkpoints, logs, catalog
  MDTPath         = "/Users/md/Library/CloudStorage/OneDrive-TheCityUniversityofNewYork/02brandeis/Brandeis Fall26/RBIF111-Bioinformatics/Week 1 Intro to fundamentals of R, obtaining open source data, and data management containers/repoquet_public_example/DBSetup.xlsx",   # the Master Database Table workbook
  PartitionBy       = "NRows",     # NRows | RAMEstimate | FAIL
  SAV_ROW_THRESHOLD = 1000000L,    # rows above which files stream in chunks
  SAV_CHUNK_SIZE    = 1000000L,    # requested rows per chunk for SAV files
  DelimitedChunkMaxMB = 256L,      # cap each CSV/TSV chunk's estimated peak memory
  DelimitedPartitionMaxMB = NULL,  # optional cap for one source-defined partition;
                                   # NULL uses a conservative bounded route budget
  RAMThreshold      = 30,          # GB, for PartitionBy = "RAMEstimate"
  MaxCoerceNAPct    = 25,          # fail a file when coercion destroys more than this % of a column
  SourceFingerprintMode = "metadata", # metadata | sha256 | none
  SchemaSurveyMode   = "adaptive", # adaptive | full | sample
  SchemaFastReadMaxBytes = 256 * 1024^2, # bounded fread fast path
  SchemaChunkSize    = 100000L,      # rows per exhaustive schema chunk
  SchemaAdaptiveSampleRows = 100000L, # rows sampled from large clean files
  SchemaFutureGlobalsMaxSizeMB = 768, # sourced-development worker allowance
  SchemaReuseCache   = TRUE,         # reuse unchanged per-source evidence
  SchemaWorkers      = min(6L, max(1L, parallel::detectCores() - 1L)),
  RemoteOffline      = FALSE,        # TRUE uses only previously cached remote sources
  DownloadPolicy    = "if_missing", # if_missing | if_changed | always | manual
  DownloadTimeout   = 10800,        # seconds
  n_workers         = max(1L, parallel::detectCores() - 1L),
  DBName            = "Repository.duckdb",
  DuckDB_GB         = "8GB"        # DuckDB memory limit (~75% of available RAM)
)

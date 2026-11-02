library(GEOquery); library(org.Hs.eg.db)
z <- getGEO("GPL570")
PlateAnnotInfo <- as.data.table(z@dataTable@table)
PlateAnnotInfo <- PlateAnnotInfo[,c("ID", "Gene Symbol", "ENTREZ_GENE_ID"), with = FALSE]
PlateAnnotInfo$`Gene Symbol` <- gsub(" ///.+", "", PlateAnnotInfo$`Gene Symbol`)
PlateAnnotInfo$ENTREZ_GENE_ID <- gsub(" ///.+", "", PlateAnnotInfo$ENTREZ_GENE_ID)
PlateAnnotInfo <- PlateAnnotInfo[!PlateAnnotInfo$`Gene Symbol` == "",]
setnames(PlateAnnotInfo, c("Gene Symbol", "ENTREZ_GENE_ID"), c("SYMBOL", "ENTREZID"))
PlateAnnotInfo <- PlateAnnotInfo[!is.na(ENTREZID),]
PlateAnnotInfo <- PlateAnnotInfo[!ENTREZID == "",]
PlateAnnotInfo$ENTREZID <- as.character(PlateAnnotInfo$ENTREZID)
mappings <- AnnotationDbi::select(org.Hs.eg.db, keys=PlateAnnotInfo$ENTREZID, columns=c("GENENAME"),keytype="ENTREZID")
PlateAnnotInfo <- unique(merge(PlateAnnotInfo, mappings, by = "ENTREZID", allow.cartesian = TRUE))
PlateAnnotInfo <- PlateAnnotInfo[,c("ID", "ENTREZID", "SYMBOL", "GENENAME")]
PlateAnnotInfo$GPLID <- "GPL570"
datatable(head(as.data.frame(PlateAnnotInfo),10), filter = 'top', options = list(pageLength = 10, scrollX = TRUE, scrollY = "400px", autoWidth = TRUE))


#---------------

ArrayData <- GEODataDownload(DS = "GSE98578",
                             gpl = "GPL570",
                             gsm = "011111111111011111111111101110011111101011101101",
                             PlateAnnotInfo = PlateAnnotInfo,
                             Technology = "Array")
names(ArrayData)
library(DESeq2); library(limma); library(data.table)

ArrayData[["Data"]]
datatable(head(as.data.frame(ArrayData[["Data"]]),10), filter = 'top', options = list(pageLength = 10, scrollX = TRUE, scrollY = "400px", autoWidth = TRUE))




install.packages("remotes")
remotes::install_github("brendangongol/repoquet", force = TRUE, build_vignettes = TRUE)
library(repoquet)
vignette("repoquet", package = "repoquet")
 browseVignettes("repoquet")


 # 
 # public_example <- generate_real_world_repository( dir = file.path(getwd(), "repoquet_public_example"),
 #                                                   profile = c("comprehensive"), # "quick", "relational", "schema_drift", "stress", "comprehensive",
 #                                                   IncludeLarge = NULL, Download = FALSE ) #, overwrite = TRUE)




 cfg <- load_repository_config(public_example$ConfigPath)
 paths <- RepositoryInitialize(cfg$FormattedDBPath)
 RunId <- new_repository_run_id()
 # Review DBSetup.xlsx, then materialize its declared sources:
 MDT <- openxlsx::read.xlsx(public_example$MDTPath, sheet = "Sheet1")
 ValidateMDTPreflight(MDT = MDT, strict = TRUE, logStatus = TRUE,
                      ParquetBasePath = paths$ParquetBasePath,
                      MaxFileStemTruncate = TRUE,
                      TerminalHivePartition = FALSE,
                      MasterDBPath = cfg$MasterDBPath,
                      LogPath = paths$LogPath, RunId = RunId)

 MDT <- MaterializeRemoteSources(MDT = MDT,
                                 DownloadCachePath = paths$DownloadCachePath,
                                 Offline = isTRUE(cfg$RemoteOffline),
                                 DefaultDownloadPolicy = cfg$DownloadPolicy %||% "if_missing",
                                 TimeoutSeconds = cfg$DownloadTimeout %||% 10800,
                                 Strict = FALSE,
                                 LogPath = paths$LogPath,
                                 RunId = RunId)
 
 
 failed <- MDT[MDT$RemoteCacheStatus == "failed", ]
 MDT <- MDT[MDT$RemoteCacheStatus != "failed", ]
 pending <- MDTCompleteStatus(MDT = MDT, CheckpointPath = paths$CheckpointPath,
                              verbose = TRUE, logStatus = TRUE,
                              MasterDBPath = cfg$MasterDBPath,
                              SourceFingerprintMode = cfg$SourceFingerprintMode)
 
 # [1] "There are 0 name duplications in MDT"
 # [1] "There are 1672 files in MDT that have not been completed"
 
 DBLoad <- sort(unique(MDT$Database))
 prepared <- PrepareSchemaRegistry(MDT = MDT,
                                   DBLoad = DBLoad,
                                   MasterDBPath = cfg$MasterDBPath,
                                   ObservationPath = paths$SchemaObservationPath,
                                   SchemaReviewPath = paths$SchemaReviewPath,
                                   n_workers = cfg$SchemaWorkers,
                                   SourceFingerprintMode = cfg$SourceFingerprintMode,
                                   SchemaSurveyMode = cfg$SchemaSurveyMode,
                                   FastReadMaxBytes = cfg$SchemaFastReadMaxBytes,
                                   SchemaChunkSize = cfg$SchemaChunkSize,
                                   AdaptiveSampleRows = cfg$SchemaAdaptiveSampleRows,
                                   FutureGlobalsMaxSizeMB = cfg$SchemaFutureGlobalsMaxSizeMB,
                                   ReuseObservationCache = cfg$SchemaReuseCache,
                                   StrictReaders = FALSE,
                                   ValuePreviewMaxDistinct = 15L,
                                   ValuePreviewTypes = c("character", "integer", "int64", "logical"),
                                   ValuePreviewIdentifiers = FALSE,
                                   SchemaRegistryPath = paths$SchemaRegistryPath,
                                   SchemaProfile = "generic",
                                   LogPath = paths$LogPath,
                                   RunId = RunId )
 # Optional bounded issue preview; this query does not load all observations.
 schema_issues <- GetSchemaObservations(ObservationPath = paths$SchemaObservationPath,
                                        IssuesOnly = TRUE, Limit = 100L)
 if(nrow(schema_issues) > 0L){ print(schema_issues) }


 repository_catalog <- FinalizeSchemaRegistry(SchemaReviewPath = paths$SchemaReviewPath,
                                              TableSchemaPath = paths$TableSchemaPath, strict = TRUE)


 
 result <- ParquetBackEndCreate(MDT = MDT,
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
                                MaterializeRemote = FALSE, # already resolved before schema survey
                                SourceFingerprintMode = cfg$SourceFingerprintMode,
                                MaxCoerceNAPct = cfg$MaxCoerceNAPct,
                                AutoCleanup = TRUE,
                                CleanupAfterPhase = "database",
                                StopOnFileError = TRUE,
                                ReturnRunResult = TRUE,
                                RunId = RunId)
 print(result)
 

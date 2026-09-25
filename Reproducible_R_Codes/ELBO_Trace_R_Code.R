dir_path <- "C:/Work Files/Simulation_Study_For_Proj_1/K=5/Alpha_true = 3/Sim_1000_50_5_3"  

files <- list.files(dir_path, pattern = "^Output_ZIFA_LSN_.*\\.RData$",
                    full.names = TRUE)


all_data <- lapply(files, function(f) {
  e <- new.env()
  load(f, envir = e)
  as.list(e)
})

elbo_diffs <- lapply(all_data, function(x) {
  obj_name <- grep("^OUTPUT_ZIFA_CAVI_", names(x), value = TRUE)[1]
  if (is.na(obj_name)) return(NULL)
  diff(unlist(x[[obj_name]]$ELBO_Trace))
})

setwd("C:/Work Files/Simulation_Study_For_Proj_1")

save(elbo_diffs, file = "ELBO_Trace_1000_50_5_3.RData")

all_increasing <- sapply(elbo_diffs, function(d) all(d > 0))

all(all_increasing)

rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load_sources ----
#Load any source files that contain/define functions, but that don't load any other types of variables
#   into memory.  Avoid side effects and don't pollute the global environment.
# source("./SomethingSomething.R")

# ---- load_packages ----

# ---- declare_globals ----

pathInput <- "./data_phi_free/raw/house.csv"
# pathInput <- "/home/wibeasley/GitHub/HousePrediction/data_phi_free/raw/house.csv"
# pathInput <- "D:/Users/Will/Documents/GitHub/HousePrediction/data_phi_free/raw/house.csv"

# ---- load_data ----
ds <- read.csv(pathInput, stringsAsFactors=T) # 'ds' stands for 'datasets'

# ---- tweak_data ----
ds$PriceMissing <- is.na(ds$PriceSold)

# ---- print_all ----
print(ds)
plot(ds)

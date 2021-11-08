# CHARGING LIBRARIES
library(shiny, warn.conflicts = FALSE)
library(shiny.semantic, warn.conflicts = FALSE)
library(leaflet, warn.conflicts = FALSE)
library(leaflet.mapboxgl, warn.conflicts = FALSE)
library(fst, warn.conflicts = FALSE)
library(geosphere, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)
library(tidyr, warn.conflicts = FALSE)
library(shinyjs, warn.conflicts = FALSE)
library(stringr, warn.conflicts = FALSE)
library(highcharter, warn.conflicts = FALSE)

# LOADING MODULES
modules_files <- list.files(paste0(getwd(), '/modules/'), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)
sapply(modules_files, source, encoding = 'UTF-8',local = FALSE)

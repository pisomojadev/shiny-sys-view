library(tidyverse)
library(shiny)
library(shinydashboard)
library(nickOAuth2)
library(httr)
library(lubridate)
library(jsonlite)
library(shinyjs)
library(plotly)

source("creds.R") # OAuth creds
source("endpoints.R") # endpoints

# get token 

nickOAuth::createOAuthToken()

# call entity data api
centralEntities <- nickOAuth::callSecureEndpoint("GET", entEndpoint) %>%
    content(type = "application/json", as = "text", encoding = "UTF-8") %>% 
    fromJSON %>% tbl_df %>% 
    mutate(logged_on = as.POSIXct(
        logged_on, 
        format = "%Y-%m-%d%h:%M:%OSZ",
        tx = "America/Chicago"
    ))

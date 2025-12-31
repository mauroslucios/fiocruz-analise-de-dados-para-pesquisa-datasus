setwd("/home/mauro-lucio-pereira-da-silva/nfs/fiocruz/data")
getwd()
library(arrow)
library(magrittr)
library(tidyverse)
df_csv <- read_csv("Dengue/csv/DENGBR25.csv")
df_parquet <- read_parquet("Zikavirus/parquet/ZIKABR24.parquet")
table(df_csv$CS_SEXO, useNA = "always")
head(df_csv)
tail(df_parquet)
df_csv %>% count(CS_SEXO, sort = TRUE)
df_csv %>% 
  count(CS_SEXO, sort = TRUE)


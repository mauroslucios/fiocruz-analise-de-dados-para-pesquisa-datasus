setwd("/home/mauro-lucio-pereira-da-silva/nfs/fiocruz/curso-analise-de-dados/dados")
getwd()
library(arrow)
library(magrittr)
library(tidyverse)
df_csv <- read_csv("sim_salvador_2023.csv")
df_csv <- df_csv %>%
  mutate(
    sexo_p = if_else(SEXO == 1 , "Masculino",
                     if_else(SEXO == 2, "Feminino",
                              if_else(SEXO == 0, "I", NA_character_)))
  )
df_csv %>% count(SEXO)
df_csv %>% count(sexo_p)

df_csv <- df_csv %>%
  mutate(
    sexo_p = case_when(
      SEXO == 1 ~ "Masculino",
      SEXO == 2 ~ "Feminino",
      SEXO == 0 ~ "Ignorado",
      is.na(SEXO) ~ NA_character_
    )
  )

df_csv <- df_csv %>%
  mutate(
    tipo_idade = str_sub(IDADE, 1, 1),
    idade = str_sub(IDADE, 2)
  )

df_csv %>%
  select(IDADE, tipo_idade, idade) %>%
  head()

df_csv <- df_csv %>%
  mutate(
    tipo_idade = str_sub(IDADE, 1, 1),
    idade = str_sub(IDADE, 2),
    idade_anos = case_when(
      tipo_idade <= 3 ~ 0,
      tipo_idade == 4 ~ as.numeric(idade),
      tipo_idade == 5 ~ 100 + as.numeric(idade)
    )
  )

glimpse(df_csv)
View(df_csv)














df_csv %>% count(SEXO)
df_csv %>% count(sexo_p)

df_csv <- df_csv %>%
  mutate(
    DTOBITO_dt = dmy(DTOBITO)
  )

df_csv <- df_csv %>%
  mutate(
    ano_obito = year(DTOBITO_dt)
  )
glimpse(df_csv)

df_csv %>% count(ano_obito)

df_csv %>% count(sexo_p, ano_obito)
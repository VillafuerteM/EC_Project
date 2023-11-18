# Proyecto de Estadística Computacional (MCD ITAM 2023)
Authors:  
Blanca E. García -   
Yuneri Pérez - 199813
Mariano Villafuerte - 156057  


## Objetivo
Desarrollar una aplicación web usando Shiny que integre el uso de un modelo predictivo. En este caso, la aplicación de Shiny le pide al usuario introducir ciertas características de algún vino que desea calificar

## Docker
Para crear la imagen de Postgres en Docker, se corre el siguiente código en terminal (aplica desde Mac M1 y M2)
```bash
docker run `
    -p 5432:5432 `
    -e POSTGRES_PASSWORD= `
    -e POSTGRES_INITDB_ARGS="--auth-local=md5" `
    -d `
    postgres
```

O si se hace desde una terminal de Ubuntu:
```bash
docker run \
       -p 5432:5432 \
       -e POSTGRES_PASSWORD= \
       -e POSTGRES_INITDB_ARGS="--auth-local=md5" \
       -d \
       postgres
```
Luego, desde R se crea la base de datos inicial. Se usan los datos de calidad de vinos 
```r
library(dplyr)

winequality <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv", 
                          header = TRUE, 
                          sep = ";") %>%
  mutate(type='white') %>%
  rbind(read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv", 
                   header = TRUE, 
                   sep = ";") %>%
          mutate(type='red'))

# usando una conexión de PostgreSQL
con <- dbConnect(
  RPostgreSQL::PostgreSQL(),
  dbname = "",
  host = "localhost",
  port = ,
  user = "",
  password = ""
)

copy_to(
  con, winequality, "wine",
  overwrite=TRUE, temporary = FALSE,
  indexes = list(
    colnames(winequality)
  )
)

# verificar si existe la tabla copiada
dbListTables(con)

# cerramos la conexión
dbDisconnect(con)
```

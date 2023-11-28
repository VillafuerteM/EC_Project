![](https://github.com/VillafuerteM/EC_Project/blob/main/imgs/descarga.png)

# Proyecto de Estadística Computacional 
# (MCD ITAM Otoño 2023)
## Proyecto Final: Calificación de Vino

![](https://github.com/VillafuerteM/EC_Project/blob/main/imgs/Vino.jpeg)           

### Integrantes del equipo

| Nombre                        |  CU    | Correo Electronico             | Usuario Gh   |
|-------------------------------|--------|--------------------------------|--------------|
| Blanca Estela García Majarrez | 118886 | bgarci11@itam.mx               | BGARCIAMA    |
| Yuneri Pérez Arellano         | 199813 | yperezar@itam.mx               | YunPerez     |
| Mariano Villafuerte Gonzalez  | 156057 | mariano.villafuerte@itam.mx    | VillafuerteM |


## Comprensión de la información
xxxxx

## Objetivo del proyecto
Desarrollar una aplicación web usando Shiny que integre el uso de un modelo predictivo para calificar un vino de acuerdo con base en sus caracteristicas. 
En este caso, la aplicación de Shiny le pedirá al usuario, introducir ciertas características de algún vino que desea calificar.

# Base de datos
La base de datos que se analizará en este proyecto será la de [Wine Quality](https://archive.ics.uci.edu/dataset/186/wine+quality) obtenida de [Wine Quality Datasets](http://www3.dsi.uminho.pt/pcortez/wine/).

# Infraestructura y Ejecución ⚙

Para ejecutar este producto de datos se necesita lo siguiente:
- Sistema operativo Linux/Mac con Docker Desktop instalado.
- Clonar el repositorio en el equipo.

**Para levantar la imagen de docker y la base de datos:**
1. Descargar el archivo `Wines.csv` que está disponible en este [**Drive**](https://drive.google.com/drive/folders/1KPu_sOSKWICQB6PY9IzwpVTDCTpSzUWx), y colocarlo en la carpeta `data` del repositorio.
2. Limpieza de datos: 
   1. Abrir una terminal, ir a la raíz del repositorio, y ejecutar 


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
   -e POSTGRES_PASSWORD=postgres \
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

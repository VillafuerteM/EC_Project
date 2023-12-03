![](https://github.com/VillafuerteM/EC_Project/blob/main/imgs/descarga.png)

# Proyecto de Estadística Computacional 
# (MCD ITAM Otoño 2023)
## Proyecto Final: Calificación de Vino 🍷

![](https://github.com/VillafuerteM/EC_Project/blob/main/imgs/Vino.jpeg)           

## Integrantes del equipo

| Nombre                        |  CU    | Correo Electrónico             | Usuario Github |
|-------------------------------|--------|--------------------------------|----------------|
| Blanca Estela García Majarrez | 118886 | bgarci11@itam.mx               | BGARCIAMA      |
| Yuneri Pérez Arellano         | 199813 | yperezar@itam.mx               | YunPerez       |
| Mariano Villafuerte Gonzalez  | 156057 | mariano.villafuerte@itam.mx    | VillafuerteM   |


# Comprensión de la información  🧠
Consulte el documento: [comprension_negocio.md](https://github.com/VillafuerteM/EC_Project/edit/main/comprension_negocio.md)

# Objetivo del proyecto  🎯
Desarrollar una aplicación web usando Shiny que integre el uso de un modelo predictivo para calificar un vino de acuerdo a sus caracteristicas fisicoquímicas (como valores de densidad, alcohol y pH). 
En este caso, la aplicación de Shiny le pedirá al usuario, introducir ciertas características de algún vino que desea calificar.

# Base de datos  ✍
La base de datos que se analizará en este proyecto será la de [Wine Quality](https://archive.ics.uci.edu/dataset/186/wine+quality) obtenida de [Wine Quality Datasets](http://www3.dsi.uminho.pt/pcortez/wine/).

Se considera información de vino verde, un producto único de la región de Minho (noroeste) de Portugal. Este vino representa el 15% de la producción total portuguesa y alrededor del 10% se exporta, en su mayoría vinos blancos. Se analizará las dos variantes más habituales, vino blanco y vino tinto procedente de la región del vino verde. Los datos se recogieron desde mayo de 2004 hasta febrero de 2007 utilizando únicamente datos de muestras con denominación de origen.

# Infraestructura y Ejecución  ⚙

## Requerimientos de Software herramientas recomendadas

1. [Cuenta de Github](https://github.com)
2. [VSCodeIDE](https://code.visualstudio.com/)
3. [Docker Desktop](https://www.docker.com/products/docker-desktop/)

Para ejecutar este producto de datos se necesita lo siguiente:
- Sistema operativo Linux/Mac con Docker Desktop instalado.
- Clonar el repositorio en el equipo.

**Para levantar la imagen de docker y la base de datos:**  📸
1. Descargar el archivo `Wines.csv` que está disponible en el siguiente [**Drive**](https://drive.google.com/drive/folders/1KPu_sOSKWICQB6PY9IzwpVTDCTpSzUWx), y colocarlo en la carpeta `data` del repositorio.
2. Construir la imagen de docker:
   En la raíz del repositorio, ejecutar estos 2 comandos en la terminal (se necesitará ingresar la contraseña del usuario de la computadora donde se está trabajando):
   1. > `make build`
   2. > `make up` 

**Para acceder a los servicios del producto de datos:**  📡
1. Abrir el explorador de internet e ir a la siguiente dirección:
   1. > `localhost:5000/main`
2. Se accede a la página principal que contiene 4 botones con las siguientes funciones:
   1. `Mostrar datos`:  Muestra la tabla disponible en la base de datos con el dataset utilizado para entrenar el modelo.  **Nota:**  Debido al tamaño del dataset usado para el entrenamiento (196,000 registros), se muestran solo 20 registros para fines ilustrativos.
   2. `Realizar predicción`:  Permite realizar una predicción, al ingresar los campos requeridos.
      1. `Job ID`:  Identificador de la predicción, valor numérico libre.
      2. `Borough Code`:  Identificador numérico del distrito de Nueva York a inspeccionarse, 5 valores numéricos posibles:
         1. Manhattan (1)
         2. Bronx (2)
         3. Brooklyn (3)
         4. Queens (4)
         5. Staten Island (5)
      3. `Zip Code`:  Código postal donde se realizará la inspección (valor numérico entre 10001 y 11220). 
      4. `Latitude`:  Latitud donde se realizará la inspección (valor numérico entre 40.49 y 40.92).
      5. `Longitude`:  Longitud donde se realizará la inspección (valor numérico entre -74.27 y -73.68).
      6. `Inspection type`:  Tipo de inspección a realizarse, seleccionar alguna de las siguientes opciones:
         1. Bait
         2. Clean up
         3. Compliance
         4. Initial
         5. Stoppage
   2. `Agregar registro`:  Permite agregar observaciones adicionales a la base de datos.
   3. `Mostrar predicciones`:  Se muestran las predicciones realizadas hasta el momento.
3. Adicionalmente, se puede visualizar y trabajar con la base de datos utilizando el servicio de `pgAdmin`, para ello, ejecutar lo siguiente:  
   1. Abrir el explorador de internet e ir a la siguiente dirección:
      1. > `localhost:8000`
   2. Después de visualizar la pantalla de bienvenida de `pgAdmin`, ingresar los siguientes datos:
         1. username:  admin@admin.com
         2. password:  admin
   3. Después de entrar al servicio de `pgAdmin`, dar click derecho sobre `Servers` en el menú de la izquierda, seleccionar `Create` y posteriormente `Server`.
   4. En la ventana que se despliega, capturar la siguiente información:
      1. Pestaña `General`: Darle nombre al servidor, por ejemplo: `Rodent`.
      2. Pestaña `Connection`:  
         1. Host name:  db
         2. Username:  root
         3. Password:  root
   5. Estarán disponibles las siguientes tablas:
      1. `all_info`:  Contiene los registros del dataset de entrenamiento del modelo.
      2. `predicted_results`:  Contiene las predicciones realizadas.  
4. Para salir de este producto de datos, hay que cerrar las pestañas del explorador y ejecutar `Ctrl+C` en la terminal donde se está corriendo la imagen de Docker.




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

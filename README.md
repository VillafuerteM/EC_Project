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
   1. > `docker-compose build`
   2. > `docker-compose up` 

**Para acceder a los servicios del producto de datos:**  📡
1. Abrir el explorador de internet e ir a la siguiente dirección:
   1. > `[localhost:5000/main](http://127.0.0.1:8050/)`
2. Se accede a la página principal que contiene una gráfica de correlación entre dos variables a elegir por el usuario sobre la base de datos de vinos:
   1. Estará disponible la siguiente información:
      1. `Analisis exploratorio`: Gráfica de correlacion entre dos variables a elegir.
      2. `Wine Quality Prediction`:  A partir de los datos ingresados por el usuario y después dar clic en `Predict`, mostrará la predicción del modelo.
4. Para salir de este producto de datos, hay que cerrar las pestañas del explorador y ejecutar `Ctrl+C` en la terminal donde se está corriendo la imagen de Docker.



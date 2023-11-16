# Proyecto de Estadística Computacional (MCD ITAM 2023)
Authors:  
Blanca  
Yuneri  
Mariano Villafuerte - 156057  


## Objetivo
Desarrollar una aplicación web usando Shiny que integre el uso de un modelo predictivo. En este caso, la aplicación de Shiny le pide al usuario introducir ciertas características de algún vino que desea calificar

## Docker
Para crear el Docker, se corre este código el Powershell
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

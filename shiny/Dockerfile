# Base image https://hub.docker.com/u/rocker/
#FROM rocker/shiny
FROM docker.io/rocker/r-ver:3.6.3

# system libraries of general use
## install debian packages
RUN apt-get update && apt-get install -y \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    xtail \
    wget

## update system libraries
RUN apt-get update && \
    apt-get install -y sudo gdebi-core && \
    apt-get clean

# install renv & restore packages
RUN R -e 'install.packages("shiny")'
RUN R -e 'install.packages(c("tidyverse", "httr", "jsonlite", "DT"))'

COPY . app/
# expose port
EXPOSE 4999

# run app on container start
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 4999)"]





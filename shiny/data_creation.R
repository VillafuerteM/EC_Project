library(dbplyr)
library(dplyr)
library(RPostgreSQL)

con <- dbConnect(
  RPostgreSQL::PostgreSQL(),
  dbname = "",
  host = "localhost",
  port = ,
  user = "",
  password = ""
)

# lectura de datos ----
winequality <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv", 
                          header = TRUE, 
                          sep = ";") %>%
  mutate(type='white') %>%
  rbind(read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv", 
                   header = TRUE, 
                   sep = ";") %>%
          mutate(type='red'))

copy_to(
  con, winequality, "wine",
  overwrite=TRUE, temporary = FALSE,
  indexes = list(
    colnames(winequality)
  )
)

# Check the connection
dbListTables(con)

# Don't forget to close the connection when you're done
dbDisconnect(con)

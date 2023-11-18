# ------------------------ Ajuste del Modelo ------------------------

# renv ----
library(renv)
renv::init()
renv::snapshot()

# librerias ----
library(dplyr)
library(xgboost)
library(caret)

# lectura de datos ----
winequality <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv", 
                          header = TRUE, 
                          sep = ";") %>%
  mutate(type='white') %>%
  rbind(read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv", 
                   header = TRUE, 
                   sep = ";") %>%
          mutate(type='red'))

# modelo ----
# convertimos a factores y nos quedamos con las variables necesarias
winequality <- winequality %>% 
  mutate(quality=quality-3,
         quality=as.factor(quality),
         type=as.factor(type)) %>%
  select(density, alcohol, citric.acid, residual.sugar, pH, type, quality)

# Split the data into training and testing sets
set.seed(102938)
train_indices <- createDataPartition(winequality$quality, p = 0.8, list = FALSE)
train_data <- winequality[train_indices, ]
test_data <- winequality[-train_indices, ]

# Create dummy variables for "type"
dummy_type <- model.matrix(~ type - 1, data = train_data)

# Combine the original data without "type" and the dummy variables
train_data_with_dummies <- cbind(train_data %>% select(-quality, -type), dummy_type)

# Specify the XGBoost model
xgb_model <- xgboost(
  data = as.matrix(train_data_with_dummies),  # Include dummy variables
  label = as.numeric(train_data$quality) - min(as.numeric(train_data$quality)),  # XGBoost requires labels starting from 0
  objective = "multi:softmax",  # Multiclass classification
  num_class = 7,  # Number of classes (wine quality levels)
  eval_metric = "mlogloss",  # Multiclass logloss for evaluation
  nrounds = 1000  # Number of boosting rounds
)

# make dummy for test
dummy_type <- model.matrix(~ type - 1, data = test_data)
test_data_with_dummies <- cbind(test_data %>% select(-type), dummy_type)

# make predictions
predictions <- predict(xgb_model, as.matrix(test_data_with_dummies%>%select(-quality)))

# Convert predicted labels back to wine quality levels
test_data_with_dummies <- test_data_with_dummies %>% mutate(prediction=predictions)


# Evaluate the model
# Evaluate the model
comp_table<- table(test_data_with_dummies$prediction, test_data_with_dummies$quality)
comp_table

u <- union(predictions, test_data_with_dummies$quality)
t <- table(factor(predictions, u), factor(test_data_with_dummies$quality, u))
confusionMatrix(t)


saveRDS(xgb_model, "xgboost_model.rds")

from flask import Flask, request, jsonify
import joblib
import pandas as pd

app = Flask(__name__)

# Cargar el modelo entrenado
model = joblib.load("path/to/your/xgboost_model.pkl")  # Asegúrate de proporcionar la ruta correcta

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Obtener los datos de la solicitud
        data = request.get_json(force=True)
        
        # Convertir los datos a un DataFrame de pandas
        input_data = pd.DataFrame(data)
        
        # Realizar la predicción
        prediction = model.predict(input_data)
        
        # Enviar la respuesta
        return jsonify({'prediction': prediction.tolist()})
    
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(port=5000)


#_________________________

from flask import Flask, request, jsonify
import xgboost
import pandas as pd
import numpy as np

app = Flask(__name__)

# Cargar el modelo XGBoost previamente entrenado
model = xgboost.Booster()
model.load_model("xgboost_model.rds")

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json(force=True)
    features = pd.DataFrame(data)
    
    # Realizar la predicción
    predictions = model.predict(xgboost.DMatrix(features))
    
    # Convertir las predicciones a la forma original (añadir 3 ya que restamos 3 antes)
    predictions = predictions + 3
    
    return jsonify(predictions.tolist())

if __name__ == '__main__':
    app.run(port=5000)

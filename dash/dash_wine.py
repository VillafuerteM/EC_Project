# main.py
from flask import Flask, request, jsonify, render_template
import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output
import requests

# Configuración de Flask
app_flask = Flask(__name__)

# Definición de la ruta principal
@app_flask.route("/")
def index():
    return render_template("index.html")

# Ruta para la predicción
@app_flask.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()
    # Aquí realizarías la lógica de predicción basada en los datos recibidos
    # y devolverías la predicción en formato JSON
    prediction = {"prediction": "Calificación predicha"}
    return jsonify(prediction)

# Configuración de Dash
app_dash = dash.Dash(__name__, server=app_flask)

# Definición de la interfaz de usuario (UI) en Dash
app_dash.layout = html.Div([
    html.H1("Calificación de Vino"),
    dcc.Input(id="density", type="number", placeholder="Densidad", value=0),
    dcc.Input(id="alcohol", type="number", placeholder="Alcohol", value=0),
    dcc.Input(id="citric_acid", type="number", placeholder="Ácido cítrico", value=0),
    dcc.Input(id="residual_sugar", type="number", placeholder="Azúcar residual", value=0),
    dcc.Input(id="pH", type="number", placeholder="pH", value=0),
    dcc.RadioItems(
        id="wine_type",
        options=[
            {"label": "Blanco", "value": "white"},
            {"label": "Rojo", "value": "red"}
        ],
        value="white"
    ),
    html.Button(id="predict_button", n_clicks=0, children="Predecir"),
    html.H3("Resultado de la Predicción:"),
    html.Div(id="prediction_output")
])

# Definición de la lógica del servidor en Dash
@app_dash.callback(
    Output("prediction_output", "children"),
    [Input("predict_button", "n_clicks")],
    prevent_initial_call=True
)
def update_output(n_clicks):
    # Construir el objeto JSON con las características del vino
    wine_data = {
        "density": float(request.form["density"]),
        "alcohol": float(request.form["alcohol"]),
        "citric_acid": float(request.form["citric_acid"]),
        "residual_sugar": float(request.form["residual_sugar"]),
        "pH": float(request.form["pH"]),
        "type": request.form["wine_type"]
    }

    # Realizar la solicitud a la API Flask para obtener la predicción
    response = requests.post("http://127.0.0.1:5000/predict", json=wine_data)
    
    # Extraer y mostrar la predicción
    prediction = response.json()["prediction"]
    return f"Calificación predicha: {prediction}"

if __name__ == "__main__":
    app_flask.run(debug=True)

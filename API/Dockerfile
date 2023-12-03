# Usamos imagen de Python
FROM python:3.9-slim-buster

RUN apt-get update \
    && apt-get -y install libpq-dev gcc \
    && pip install psycopg2

# Establecemos el directorio de trabajo del contenedor
WORKDIR /app

# Copiamos el contenido del directorio actual a /app
COPY . /app

# Create a virtual environment
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Copy the requirements.txt file and install Python dependencies
COPY requirements.txt /
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "main.py", "--host", "0.0.0.0", "--port", "8080"]
FROM python:3.8

RUN apt-get update

RUN apt-get -y install \
	build-essential \
	python-dev \
	python-setuptools \
    gcc \
    libc-dev \
    libpq-dev \
    g++

WORKDIR /app

COPY requirements.txt .

RUN pip install Cython --install-option="--no-cython-compile"
RUN pip install scikit-learn==0.24.1
RUN pip install -r requirements.txt

EXPOSE 5000

COPY . .

#-------------------------------------------------------------

# Use an official Python runtime as a parent image
FROM python:3.8

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "./shiny/app.py"]

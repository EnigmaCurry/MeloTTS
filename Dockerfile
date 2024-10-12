FROM python:3.9-slim
WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential libsndfile1 \
    && rm -rf /var/lib/apt/lists/*
RUN pip install --upgrade pip
COPY setup.py requirements.txt /app
RUN pip install -r requirements.txt
COPY . /app
RUN pip install -e .
RUN python -m unidic download
RUN python melo/init_downloads.py

CMD ["python", "./melo/app.py", "--host", "0.0.0.0", "--port", "8888"]

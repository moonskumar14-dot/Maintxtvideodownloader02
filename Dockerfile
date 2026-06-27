FROM python:3.11-slim-bookworm

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    wget \
    pv \
    jq \
    python3-dev \
    ffmpeg \
    mediainfo \
    aria2 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD gunicorn app:app --bind 0.0.0.0:${PORT:-8000} --workers 1 --threads 2 & python3 main.py

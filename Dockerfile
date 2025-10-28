FROM python:3.11-slim
WORKDIR /app
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
COPY setup.cfg .
COPY pyproject.toml .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt
COPY opennsfw2/ ./opennsfw2/
COPY README.md .
COPY LICENSE .
RUN pip install --no-cache-dir .
ENV PYTHONUNBUFFERED=1
CMD ["python"]


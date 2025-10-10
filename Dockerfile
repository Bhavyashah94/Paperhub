FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

# Copy requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install spaCy model and NLTK data
RUN pip install --no-cache-dir en_core_web_sm && \
    python -m nltk.downloader punkt stopwords

# Copy application code and schema
COPY . .

# Create uploads folder
RUN mkdir -p uploads

# Expose port
EXPOSE 5000

# Start Gunicorn with 1 worker and 2 threads
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "1", "--threads", "2", "app:app"]

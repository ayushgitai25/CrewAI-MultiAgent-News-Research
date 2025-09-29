FROM python:3.11-slim

WORKDIR /app

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all application files
COPY . .

# Create directories
RUN mkdir -p outputs logs

# Expose both ports
EXPOSE 8000 8501

# Simple command: Start backend in background, then frontend in foreground
CMD python app.py & streamlit run frontend_streamlit.py --server.port=8501 --server.address=0.0.0.0 --server.headless=true

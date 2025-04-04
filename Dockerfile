# Base image
FROM python:3.12.3-alpine3.19
LABEL authors="anderson.monteiro"

# Set environment variables
ENV PYTHON UNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recomends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Create and set workdir
WORKDIR /app





ENTRYPOINT ["top", "-b"]
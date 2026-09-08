FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PORT=5000

WORKDIR /app

# Install CA certificates
RUN apt-get update && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Add NetFree CA
COPY netfree-ca.crt /usr/local/share/ca-certificates/netfree-ca.crt

RUN update-ca-certificates && \
    ls -l /etc/ssl/certs/ | grep -i netfree

# Copy application
COPY app/ /app/

# Install dependencies
RUN pip install --trusted-host pypi.org \
                --trusted-host files.pythonhosted.org \
                --no-cache-dir -r /app/requirements.txt

# Create non-root user
RUN useradd --create-home --shell /bin/bash appuser || true
USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5000/health')" || exit 1

CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:5000", "app:app"]
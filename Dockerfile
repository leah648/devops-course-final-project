FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PORT=5000

WORKDIR /app

# Copy application code
COPY app/ /app/

# Install dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt

# Create a non-root user and switch to it (best-effort for slim images)
RUN useradd --create-home --shell /bin/bash appuser || true
USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://127.0.0.1:${PORT}/health || exit 1

CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:5000", "app:app"]

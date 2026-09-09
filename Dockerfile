FROM python:3.11-alpine

ENV PYTHONUNBUFFERED=1 \
    PORT=5000

WORKDIR /app

RUN apk add --no-cache ca-certificates bash && \
    addgroup -S appuser && \
    adduser -S -G appuser appuser

# Copy application
COPY app/ /app/

# Install dependencies
RUN pip install --trusted-host pypi.org \
                --trusted-host files.pythonhosted.org \
                --no-cache-dir -r /app/requirements.txt

USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5000/health')" || exit 1

CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:5000", "app:app"]
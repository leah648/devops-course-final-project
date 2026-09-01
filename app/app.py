from flask import Flask, jsonify
import os
import logging

app = Flask(__name__)
log = app.logger
log.setLevel(logging.INFO)

@app.route("/")
def hello():
    return "Hello World"

@app.route("/health")
def health():
    return jsonify(status="ok"), 200

@app.route("/ready")
def ready():
    return jsonify(ready=True), 200

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    # Listen on all interfaces so containers and k8s can reach it
    app.run(host="0.0.0.0", port=port)

import json

from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        'message': "welcome to the home page"
    })

if __name__ == "__main__":
    app.run(debug=True)
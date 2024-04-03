import json
import face_recognition

from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        'message': "welcome to the home page"
    })

@app.route('/detect_faces', methods=['POST'])
def detect_faces():
    # Check if an image is uploaded
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400

    # Read the uploaded image
    uploaded_image = request.files['image'].read()

    # Load the image using face_recognition library
    image = face_recognition.load_image_file(uploaded_image)

    # Find all face locations in the image
    face_locations = face_recognition.face_locations(image)

    # If no faces are found
    if not face_locations:
        return jsonify({'error': 'No faces detected'}), 400

    # Create an empty list to store face encodings
    face_encodings = []

    # Generate 128-dimensional face encodings for each face
    for face_location in face_locations:
        # Extract the face from the image
        top, right, bottom, left = face_location
        face_image = image[top:bottom, left:right]

        # Generate the face encoding
        face_encoding = face_recognition.face_encodings(face_image)[0]
        face_encodings.append(face_encoding.tolist())

    # Return the face encodings in a JSON array
    return jsonify({'face_encodings': face_encodings}), 200

if __name__ == "__main__":
    app.run(debug=True)
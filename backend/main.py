from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

import tensorflow as tf
import numpy as np
import pandas as pd
import joblib
import json

from PIL import Image

app = FastAPI()

# -----------------------------------
# Load Crop Recommendation Model
# -----------------------------------

crop_model = joblib.load("crop_model.pkl")

# -----------------------------------
# Load Disease Detection Model
# -----------------------------------

disease_model = tf.keras.models.load_model("disease_model.h5")

with open("class_names.json", "r") as f:
    class_names = json.load(f)
    # -----------------------------------
# Disease Solutions Database
# -----------------------------------

disease_solutions = {

    "Tomato_Late_blight": {
        "solution": "Apply copper fungicide and remove infected leaves",
        "prevention": "Avoid overhead irrigation and maintain proper spacing"
    },

    "Tomato_Early_blight": {
        "solution": "Use recommended fungicide and remove infected leaves",
        "prevention": "Practice crop rotation"
    },

    "Tomato_healthy": {
        "solution": "No treatment needed",
        "prevention": "Continue good farming practices"
    },

    "Potato_Late_blight": {
        "solution": "Spray fungicide immediately",
        "prevention": "Use disease-free seed and avoid excess moisture"
    }
}

# -----------------------------------
# CORS
# -----------------------------------

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# -----------------------------------
# Request Models
# -----------------------------------

class ChatRequest(BaseModel):
    message: str


class CropRequest(BaseModel):
    N: float
    P: float
    K: float
    temperature: float
    humidity: float
    ph: float
    rainfall: float


class PriceRequest(BaseModel):
    crop: str

# -----------------------------------
# Home API
# -----------------------------------

@app.get("/")
def home():
    return {
        "message": "Krishi Mitra Backend Running"
    }

# -----------------------------------
# Chatbot API
# -----------------------------------

@app.post("/chat")
def chat(req: ChatRequest):

    msg = req.message.lower()

    if "rice" in msg:
        return {
            "reply": "Rice grows best in water-rich soil 🌾"
        }

    elif "fertilizer" in msg:
        return {
            "reply": "Use organic compost for better soil health 🌱"
        }

    elif "weather" in msg:
        return {
            "reply": "Check weather before irrigation ☁️"
        }

    else:
        return {
            "reply": "I am Krishi AI Assistant 🤖"
        }

# -----------------------------------
# Crop Recommendation API
# -----------------------------------

@app.post("/recommend-crop")
def recommend_crop(req: CropRequest):

    data = pd.DataFrame([[
        req.N,
        req.P,
        req.K,
        req.temperature,
        req.humidity,
        req.ph,
        req.rainfall
    ]], columns=[
        "N",
        "P",
        "K",
        "temperature",
        "humidity",
        "ph",
        "rainfall"
    ])

    prediction = crop_model.predict(data)[0]

    return {
        "recommended_crop": prediction
    }
# -----------------------------------
# Disease Detection API
# -----------------------------------

@app.post("/detect-disease")
async def detect_disease(file: UploadFile = File(...)):

    image = Image.open(file.file).convert("RGB")

    image = image.resize((224, 224))

    image_array = np.array(image) / 255.0

    image_array = np.expand_dims(
        image_array,
        axis=0
    )

    prediction = disease_model.predict(
        image_array
    )

    class_index = np.argmax(
        prediction
    )

    disease_name = class_names[
        class_index
    ]
    display_name = disease_name.replace("_", " ")

    confidence = float(
        np.max(prediction) * 100
    )

    info = disease_solutions.get(
        disease_name,
        {
            "solution":
                "No solution available",
            "prevention":
                "No prevention data available"
        }
    )

    return {
        "disease": display_name,
        "confidence": round(
            confidence,
            2
        ),
        "solution":
            info["solution"],
        "prevention":
            info["prevention"]
    }
# -----------------------------------
# Price Prediction API
# -----------------------------------

@app.post("/predict-price")
def predict_price(req: PriceRequest):

    crop = req.crop.lower()

    if crop == "rice":
        price = "₹2800 / Quintal"

    elif crop == "wheat":
        price = "₹2400 / Quintal"

    elif crop == "tomato":
        price = "₹50 / Kg"

    else:
        price = "Price data unavailable"

    return {
        "predicted_price": price
    }

# -----------------------------------
# Run Server
# -----------------------------------

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8000,
        reload=True
    )
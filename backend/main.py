from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import joblib
import pandas as pd

app = FastAPI()

# -------------------------
# Load Crop Recommendation Model
# -------------------------

crop_model = joblib.load("crop_model.pkl")

# -------------------------
# CORS for Flutter Web
# -------------------------

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# -------------------------
# Request Models
# -------------------------

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


class DiseaseRequest(BaseModel):
    crop: str


class PriceRequest(BaseModel):
    crop: str


# -------------------------
# Home API
# -------------------------

@app.get("/")
def home():
    return {
        "message": "Krishi Mitra Backend Running"
    }


# -------------------------
# Chatbot API
# -------------------------

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


# -------------------------
# AI Crop Recommendation API
# -------------------------

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


# -------------------------
# Disease Detection API
# -------------------------

@app.post("/detect-disease")
def detect_disease(req: DiseaseRequest):

    crop = req.crop.lower()

    if crop == "tomato":
        return {
            "disease": "Leaf Spot",
            "solution": "Spray neem oil once a week"
        }

    elif crop == "rice":
        return {
            "disease": "Brown Spot",
            "solution": "Apply recommended fungicide"
        }

    elif crop == "potato":
        return {
            "disease": "Late Blight",
            "solution": "Remove infected leaves and spray fungicide"
        }

    else:
        return {
            "disease": "Healthy Crop",
            "solution": "No disease detected"
        }


# -------------------------
# Price Prediction API
# -------------------------

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
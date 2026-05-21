from fastapi import FastAPI

app = FastAPI()

# Home Route
@app.get("/")
def home():
    return {"message": "Krishi Mitra Backend Running"}

# Crops Route
@app.get("/crops")
def get_crops():

    crops = [
        {
            "crop_name": "Rice",
            "price": 25,
            "quantity": "100kg"
        },
        {
            "crop_name": "Wheat",
            "price": 30,
            "quantity": "50kg"
        }
    ]

    return {"available_crops": crops}
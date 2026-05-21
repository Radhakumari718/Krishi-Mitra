from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {"message": "Krishi Mitra Backend Running"}
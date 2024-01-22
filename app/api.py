import uvicorn
from fastapi import FastAPI, Request
from llama_cpp import Llama
import logging
from logging.handlers import RotatingFileHandler

# Setup Logging
log_file = "app.log"
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        RotatingFileHandler(log_file, maxBytes=10000000, backupCount=3),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

# Initialize FastAPI app
app = FastAPI()

# Load Llama model
LLM = Llama(model_path="./llama-2-7b-chat.ggmlv3.q8_0.bin")

@app.get("/")
async def index():
    logger.info("Accessed the index route")
    return {"message": "Hello World"}

@app.get("/health")
async def health():
    logger.info("Health check accessed")
    return {"Health": "Up"}

@app.post("/ask")
async def prompt(req: Request):
    logger.info("Received request in /ask")
    try:
        body = await req.json()
        prompt = body['question']
        answer = LLM(prompt)["choices"][0]["text"]
        return {"answer": answer}
    except Exception as e:
        logger.error(f"Error in /ask: {e}", exc_info=True)
        raise e

if __name__ == "__main__":
    uvicorn.run("api:app", host="0.0.0.0", port=80, reload=False)

import os
from pathlib import Path


class Config:
    class Path:
        APP_HOME = Path(os.getenv("APP_HOME", Path(__file__).parent.parent))
        DATABASE_DIR = APP_HOME / "docs-db"
        DOCUMENTS_DIR = APP_HOME / "tmp"
        IMAGES_DIR = APP_HOME / "images"

    class Database:
        DOCUMENTS_COLLECTION = "documents"

    class Model:
        EMBEDDINGS = os.getenv("LLM_EMBEDDINGS", "BAAI/bge-base-en-v1.5")
        RERANKER = os.getenv("LLM_RERANKER", "ms-marco-MiniLM-L-12-v2")
        LOCAL_LLM = os.getenv("LOCAL_LLM", "gemma2:9b")
        PULL_LOCAL_LLM = os.getenv("PULL_LOCAL_LLM", "true") == 'true'
        REMOTE_LLM = os.getenv("REMOTE_LLM", "llama-3.1-70b-versatile")
        TEMPERATURE = float(os.getenv("LLM_TEMPERATURE", "0.0"))
        MAX_TOKENS = int(os.getenv("LLM_MAX_TOKENS", "8000"))
        OLLAMA_BASE_URL = os.getenv("OLLAMA_BASE_URL", "http://localhost:11434")

    class Retriever:
        USE_RERANKER = True
        USE_CHAIN_FILTER = False

    DEBUG = os.getenv("DEBUG") == 'true'
    CONVERSATION_MESSAGES_LIMIT = int(os.getenv("CONVERSATION_MESSAGES_LIMIT", "-1"))

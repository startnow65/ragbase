# RagBase - Private Chat with Your Documents

> Completely local RAG with chat UI

<a href="https://www.mlexpert.io/bootcamp" target="_blank">
  <img src="https://raw.githubusercontent.com/curiousily/ragbase/master/.github/ui.png">
</a>

## Demo

Check out the [RagBase on Streamlit Cloud](https://ragbase.streamlit.app/). Runs with Groq API.

## Installation

Clone the repo:

```sh
git clone git@github.com:curiousily/ragbase.git
cd ragbase
```

Install the dependencies (requires Poetry):

```sh
poetry install
```

Fetch your LLM (gemma2:9b by default):

```sh
ollama pull gemma2:9b
```

Run the Ollama server

```sh
ollama serve
```

Start RagBase:

```sh
poetry run streamlit run app.py
```

## Architecture

<a href="https://www.mlexpert.io/bootcamp" target="_blank">
  <img src="https://raw.githubusercontent.com/curiousily/ragbase/master/.github/architecture.png">
</a>

### Ingestor

Extracts text from PDF documents and creates chunks (using semantic and character splitter) that are stored in a vector databse

### Retriever

Given a query, searches for similar documents, reranks the result and applies LLM chain filter before returning the response.

### QA Chain

Combines the LLM with the retriever to answer a given user question

## Environment variables
| Name | Description | Default value |
| ---- |------------ | --------------|
| `STREAMLIT_SERVER_MAX_UPLOAD_SIZE` | Maximum size of each file to upload for analysis in MB | `"10"` |
| `APP_HOME` | Used as base for app related files | `"/app"` |
| `LLM_EMBEDDINGS` | Model to use for Embeddings | `"BAAI/bge-base-en-v1.5"` |
| `LLM_RERANKER` | Model to use for reranking | `"ms-marco-MiniLM-L-12-v2"` |
| `LOCAL_LLM` | Model to use when using local LLM via Ollama | `"gemma2:9b"` |
| `PULL_LOCAL_LLM` | Indicates if a request should be made to Ollama to pull the model to use | `"true"` |
| `REMOTE_LLM` | Model to use when using remote LLM fromm Grok | `"llama-3.1-70b-versatile"` |
| `LLM_TEMPERATURE` | Model temperature parameter | `"0.0"` |
| `LLM_MAX_TOKENS` | Max number of tokens for model | `"8000"` |
| `OLLAMA_BASE_URL` | The base URL of Ollama. For example `http://localhost:11434`. When not set, then remote LLM is used via Grok. In this case, `GROK_API_KEY` must also be set | `` |
| `DEBUG` | Enable debug logging | `"true"` |
| `CONVERSATION_MESSAGES_LIMIT` | Max number of conversations with the uploaded files. Set to a negative number to not limits the number of conversations | `"-1"` |
| `GROQ_API_KEY` | The API Key to use for Grok | `""` |

## Tech Stack

- [Ollama](https://ollama.com/) - run local LLM
- [Groq API](https://groq.com/) - fast inference for mutliple LLMs
- [LangChain](https://www.langchain.com/) - build LLM-powered apps
- [Qdrant](https://qdrant.tech/) - vector search/database
- [FlashRank](https://github.com/PrithivirajDamodaran/FlashRank) - fast reranking
- [FastEmbed](https://qdrant.github.io/fastembed/) - lightweight and fast embedding generation
- [Streamlit](https://streamlit.io/) - build UI for data apps
- [PDFium](https://pdfium.googlesource.com/pdfium/) - PDF processing and text extraction

FROM ubuntu:24.10

RUN apt-get update --assume-yes && \
  apt-get install build-essential python3 python3-venv python3-dev --assume-yes

ENV POETRY_HOME=/opt/poetry
ENV PATH=$POETRY_HOME/bin:$PATH
ENV USER_HOME=/home/app

RUN useradd --home-dir $USER_HOME --user-group app && \
  mkdir $POETRY_HOME $USER_HOME && \
  chown --recursive app:app $POETRY_HOME $USER_HOME

USER app
RUN python3 -m venv $POETRY_HOME && \
  $POETRY_HOME/bin/pip install poetry==2.0.0 && \
  poetry --version

COPY . $USER_HOME/
WORKDIR $USER_HOME

RUN poetry install

# App Env Vars
ENV STREAMLIT_SERVER_MAX_UPLOAD_SIZE="10"
ENV APP_HOME=$USER_HOME
ENV LLM_EMBEDDINGS="BAAI/bge-base-en-v1.5"
ENV LLM_RERANKER="ms-marco-MiniLM-L-12-v2"
ENV LOCAL_LLM="gemma2:9b"
ENV REMOTE_LLM="llama-3.1-70b-versatile"
ENV LLM_TEMPERATURE="0.0"
ENV LLM_MAX_TOKENS="8000"
ENV OLLAMA_BASE_URL=""
ENV DEBUG="true"
ENV CONVERSATION_MESSAGES_LIMIT="-1"
ENV GROQ_API_KEY=""

EXPOSE 8501
ENTRYPOINT [ "poetry", "run", "streamlit", "run", "app.py" ]

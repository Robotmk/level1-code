FROM mcr.microsoft.com/devcontainers/python:3.12
#RUN useradd -m vscode
WORKDIR /workspace
COPY requirements.txt .

#RUN apt-get update && apt-get install -y --no-install-recommends \
#    git \
# && rm -rf /var/lib/apt/lists/*

RUN apt update && apt install icu-devtools -y && rm -rf /var/lib/apt/lists/*
# Verwende ein allgemeines Basis-Image, z. B. Ubuntu
FROM ubuntu:22.04

# Setze Umgebungsvariablen für eine nicht-interaktive Installation
ENV DEBIAN_FRONTEND=noninteractive

# Installiere grundlegende Entwicklungswerkzeuge
RUN apt-get update && apt-get install -y \
    build-essential \
    gdb \             
    cmake \            
    git \              
    curl \  
    cpputest \ 
    clang-tidy \
    clang-format \
    cppcheck \           
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Benutzer hinzufügen (anstelle des "vscode"-Benutzers)
RUN useradd -m -s /bin/bash devuser

# Benutzer wechseln, um Container nicht als root auszuführen
USER devuser

# Arbeitsverzeichnis festlegen
WORKDIR /workspace
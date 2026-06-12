#!/bin/bash

# Script 05 - Deploy do site estático do e-commerce
# Tema: Infraestrutura para um Pequeno E-Commerce
# Aluno: Vinícius Minas

ORIGEM="/app/source"
DESTINO="/var/www/html"
LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/05_deploy.log"

criar_diretorio_log() {
    mkdir -p "$LOG_DIR"
}

validar_origem() {
    if [ ! -d "$ORIGEM" ]; then
        echo "Diretório de origem não encontrado: $ORIGEM"
        echo "[ERRO] Diretório de origem não encontrado em $(date)" >> "$LOG_FILE"
        exit 1
    fi

    if [ ! -f "$ORIGEM/index.html" ]; then
        echo "Arquivo index.html não encontrado em $ORIGEM"
        echo "[ERRO] index.html não encontrado na origem em $(date)" >> "$LOG_FILE"
        exit 1
    fi
}

limpar_destino() {
    echo "Limpando diretório de publicação do Apache..."
    rm -rf "$DESTINO"/*
    echo "[INFO] Diretório $DESTINO limpo em $(date)" >> "$LOG_FILE"
}

realizar_deploy() {
    echo "Realizando deploy do site estático do pequeno e-commerce..."
    echo "Origem: $ORIGEM"
    echo "Destino: $DESTINO"

    cp -r "$ORIGEM"/* "$DESTINO"/

    if [ -f "$DESTINO/index.html" ]; then
        echo "Deploy realizado com sucesso."
        echo "[SUCESSO] Deploy realizado em $(date)" >> "$LOG_FILE"
    else
        echo "Falha no deploy. index.html não encontrado no destino."
        echo "[ERRO] Falha no deploy em $(date)" >> "$LOG_FILE"
        exit 1
    fi
}

listar_publicados() {
    echo "Arquivos publicados em $DESTINO:"
    ls -lh "$DESTINO"
}

criar_diretorio_log
validar_origem
limpar_destino
realizar_deploy
listar_publicados
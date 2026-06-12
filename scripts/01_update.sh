#!/bin/bash

# Script 01 - Atualização do sistema
# Tema: Infraestrutura para um Pequeno E-Commerce
# Aluno: Vinícius Minas

LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/01_update.log"

criar_diretorio_log() {
    mkdir -p "$LOG_DIR"
}

atualizar_sistema() {
    echo "Iniciando atualização do sistema..."
    echo "==== Atualização iniciada em $(date) ====" >> "$LOG_FILE"

    apt update && apt upgrade -y >> "$LOG_FILE" 2>&1

    if [ $? -eq 0 ]; then
        echo "Sistema atualizado com sucesso."
        echo "[SUCESSO] Sistema atualizado em $(date)" >> "$LOG_FILE"
    else
        echo "Falha ao atualizar o sistema. Verifique o arquivo de log."
        echo "[ERRO] Falha na atualização em $(date)" >> "$LOG_FILE"
    fi
}

criar_diretorio_log
atualizar_sistema
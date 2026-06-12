#!/bin/bash

# Script 04 - Backup automatizado
# Tema: Infraestrutura para um Pequeno E-Commerce
# Aluno: Vinícius Minas

ORIGEM="/app/ecommerce"
DESTINO="/app/backups"
LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/04_backup.log"
DATA_HORA=$(date +"%Y-%m-%d_%H-%M-%S")
ARQUIVO_BACKUP="$DESTINO/backup_ecommerce_$DATA_HORA.tar.gz"

criar_diretorios() {
    mkdir -p "$DESTINO"
    mkdir -p "$LOG_DIR"
}

validar_origem() {
    if [ ! -d "$ORIGEM" ]; then
        echo "Diretório de origem não encontrado: $ORIGEM"
        echo "[ERRO] Diretório de origem não encontrado em $(date)" >> "$LOG_FILE"
        exit 1
    fi
}

gerar_backup() {
    echo "Iniciando backup do pequeno e-commerce..."
    echo "Origem: $ORIGEM"
    echo "Destino: $ARQUIVO_BACKUP"

    echo "==== Backup iniciado em $(date) ====" >> "$LOG_FILE"

    tar -czf "$ARQUIVO_BACKUP" -C /app ecommerce >> "$LOG_FILE" 2>&1

    if [ -f "$ARQUIVO_BACKUP" ]; then
        echo "Backup criado com sucesso:"
        echo "$ARQUIVO_BACKUP"
        echo "[SUCESSO] Backup criado: $ARQUIVO_BACKUP em $(date)" >> "$LOG_FILE"
    else
        echo "Falha ao criar o backup."
        echo "[ERRO] Falha ao criar backup em $(date)" >> "$LOG_FILE"
        exit 1
    fi
}

listar_backups() {
    echo "Backups disponíveis:"
    ls -lh "$DESTINO"
}

criar_diretorios
validar_origem
gerar_backup
listar_backups
#!/bin/bash

# Script 03 - Estrutura de diretórios temática
# Tema: Infraestrutura para um Pequeno E-Commerce
# Aluno: Vinícius Minas

BASE_DIR="/app/ecommerce"
LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/03_estrutura.log"

criar_diretorio_log() {
    mkdir -p "$LOG_DIR"
}

remover_estrutura_antiga() {
    if [ -d "$BASE_DIR" ]; then
        echo "Removendo estrutura antiga do e-commerce com segurança..."
        rm -rf "$BASE_DIR"
        echo "[INFO] Estrutura antiga removida em $(date)" >> "$LOG_FILE"
    else
        echo "Nenhuma estrutura antiga encontrada."
        echo "[INFO] Nenhuma estrutura antiga encontrada em $(date)" >> "$LOG_FILE"
    fi
}

criar_estrutura_ecommerce() {
    echo "Criando estrutura temática do pequeno e-commerce..."

    mkdir -p "$BASE_DIR/produtos"
    mkdir -p "$BASE_DIR/pedidos"
    mkdir -p "$BASE_DIR/clientes"
    mkdir -p "$BASE_DIR/publicacao"
    mkdir -p "$BASE_DIR/dados"
    mkdir -p "$BASE_DIR/logs"
    mkdir -p "$BASE_DIR/backups"

    touch "$BASE_DIR/produtos/catalogo.txt"
    touch "$BASE_DIR/pedidos/pedidos_pendentes.txt"
    touch "$BASE_DIR/clientes/clientes_cadastrados.txt"
    touch "$BASE_DIR/dados/resumo_operacional.txt"

    echo "Estrutura criada com sucesso em $BASE_DIR"
    echo "[SUCESSO] Estrutura temática criada em $(date)" >> "$LOG_FILE"
}

listar_estrutura() {
    echo "Listando estrutura criada:"
    find "$BASE_DIR" -maxdepth 2 -type d
}

criar_diretorio_log
remover_estrutura_antiga
criar_estrutura_ecommerce
listar_estrutura
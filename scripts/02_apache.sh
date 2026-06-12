#!/bin/bash

# Script 02 - Instalação e validação do Apache
# Tema: Infraestrutura para um Pequeno E-Commerce
# Aluno: Vinícius Minas

LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/02_apache.log"

criar_diretorio_log() {
    mkdir -p "$LOG_DIR"
}

instalar_apache() {
    echo "Instalando Apache..."
    echo "==== Instalação do Apache iniciada em $(date) ====" >> "$LOG_FILE"

    apt update >> "$LOG_FILE" 2>&1
    apt install -y apache2 >> "$LOG_FILE" 2>&1

    if [ $? -eq 0 ]; then
        echo "Apache instalado com sucesso."
        echo "[SUCESSO] Apache instalado em $(date)" >> "$LOG_FILE"
    else
        echo "Falha ao instalar Apache."
        echo "[ERRO] Falha na instalação do Apache em $(date)" >> "$LOG_FILE"
    fi
}

verificar_apache() {
    echo "Verificando Apache..."

    if command -v apache2 > /dev/null 2>&1; then
        echo "Apache está instalado."
        echo "[OK] Apache encontrado no sistema." >> "$LOG_FILE"
    else
        echo "Apache não está instalado."
        echo "[ALERTA] Apache não encontrado." >> "$LOG_FILE"
    fi
}

versao_apache() {
    echo "Versão do Apache:"
    apache2 -v

    echo "==== Versão do Apache ====" >> "$LOG_FILE"
    apache2 -v >> "$LOG_FILE" 2>&1
}

criar_diretorio_log
instalar_apache
verificar_apache
versao_apache
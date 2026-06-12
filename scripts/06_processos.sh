#!/bin/bash

# Script 06 - Gerenciamento de processos
# Tema: Infraestrutura para um Pequeno E-Commerce
# Aluno: Vinícius Minas

LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/06_processos.log"

criar_diretorio_log() {
    mkdir -p "$LOG_DIR"
}

listar_processos() {
    echo "Listando processos ativos no ambiente Linux..."
    echo "==== Listagem de processos em $(date) ====" >> "$LOG_FILE"

    ps aux | head -20

    echo "[INFO] Processos listados em $(date)" >> "$LOG_FILE"
}

buscar_processo() {
    NOME_PROCESSO="$1"

    if [ -z "$NOME_PROCESSO" ]; then
        echo "Informe o nome do processo que deseja buscar."
        echo "Exemplo: ./06_processos.sh buscar apache"
        echo "[ERRO] Busca sem nome de processo em $(date)" >> "$LOG_FILE"
        exit 1
    fi

    echo "Buscando processo com nome: $NOME_PROCESSO"
    echo "==== Busca por processo: $NOME_PROCESSO em $(date) ====" >> "$LOG_FILE"

    ps aux | grep -i "$NOME_PROCESSO" | grep -v grep

    if [ $? -eq 0 ]; then
        echo "[OK] Processo encontrado."
        echo "[OK] Processo $NOME_PROCESSO encontrado em $(date)" >> "$LOG_FILE"
    else
        echo "[ALERTA] Nenhum processo encontrado com esse nome."
        echo "[ALERTA] Processo $NOME_PROCESSO não encontrado em $(date)" >> "$LOG_FILE"
    fi
}

matar_processo() {
    PID="$1"

    if [ -z "$PID" ]; then
        echo "Nenhum PID informado."
        echo "Uso correto: ./06_processos.sh matar <PID>"
        echo "[ERRO] Tentativa de encerrar processo sem PID em $(date)" >> "$LOG_FILE"
        exit 1
    fi

    if ! [[ "$PID" =~ ^[0-9]+$ ]]; then
        echo "PID inválido. Informe apenas números."
        echo "[ERRO] PID inválido informado: $PID em $(date)" >> "$LOG_FILE"
        exit 1
    fi

    if [ "$PID" -eq 1 ]; then
        echo "Por segurança, o processo PID 1 não será encerrado."
        echo "[ALERTA] Tentativa bloqueada de encerrar PID 1 em $(date)" >> "$LOG_FILE"
        exit 1
    fi

    if ps -p "$PID" > /dev/null 2>&1; then
        echo "Encerrando processo PID $PID..."
        kill "$PID"

        if [ $? -eq 0 ]; then
            echo "Processo $PID encerrado com sucesso."
            echo "[SUCESSO] Processo $PID encerrado em $(date)" >> "$LOG_FILE"
        else
            echo "Falha ao encerrar o processo $PID."
            echo "[ERRO] Falha ao encerrar processo $PID em $(date)" >> "$LOG_FILE"
        fi
    else
        echo "Processo com PID $PID não encontrado."
        echo "[ALERTA] PID $PID não encontrado em $(date)" >> "$LOG_FILE"
    fi
}

exibir_ajuda() {
    echo "Uso do script de processos:"
    echo "./06_processos.sh listar"
    echo "./06_processos.sh buscar apache"
    echo "./06_processos.sh matar 1234"
}

criar_diretorio_log

case "$1" in
    listar)
        listar_processos
        ;;
    buscar)
        buscar_processo "$2"
        ;;
    matar)
        matar_processo "$2"
        ;;
    *)
        exibir_ajuda
        ;;
esac
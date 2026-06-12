#!/bin/bash

# Script 07 - Monitoramento do sistema
# Tema: Infraestrutura para um Pequeno E-Commerce
# Aluno: Vinícius Minas

LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/07_monitoramento.log"
DATA_HORA=$(date +"%Y-%m-%d %H:%M:%S")

criar_diretorio_log() {
    mkdir -p "$LOG_DIR"
}

calcular_cpu() {
    CPU_USO=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2 + $4)}')

    if [ -z "$CPU_USO" ]; then
        CPU_USO=0
    fi
}

verificar_memoria() {
    MEMORIA_USO=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

    if [ -z "$MEMORIA_USO" ]; then
        MEMORIA_USO=0
    fi
}

verificar_disco() {
    DISCO_USO=$(df /app | awk 'NR==2 {gsub("%",""); print $5}')

    if [ -z "$DISCO_USO" ]; then
        DISCO_USO=0
    fi
}

verificar_apache() {
    if pgrep -f "apache2|apachectl" > /dev/null 2>&1; then
        APACHE_STATUS="em execução"
    else
        APACHE_STATUS="parado"
    fi
}

exibir_monitoramento() {
    echo "===== MONITORAMENTO DO SISTEMA ====="
    echo "Data/Hora da coleta: $DATA_HORA"
    echo "Tema: Infraestrutura para um Pequeno E-Commerce"
    echo "Uso de CPU: ${CPU_USO}%"
    echo "Uso de memória RAM: ${MEMORIA_USO}%"
    echo "Uso de disco em /app: ${DISCO_USO}%"
    echo "Status do Apache: $APACHE_STATUS"
    echo "===================================="

    echo "===== MONITORAMENTO DO SISTEMA =====" >> "$LOG_FILE"
    echo "Data/Hora da coleta: $DATA_HORA" >> "$LOG_FILE"
    echo "Uso de CPU: ${CPU_USO}%" >> "$LOG_FILE"
    echo "Uso de memória RAM: ${MEMORIA_USO}%" >> "$LOG_FILE"
    echo "Uso de disco em /app: ${DISCO_USO}%" >> "$LOG_FILE"
    echo "Status do Apache: $APACHE_STATUS" >> "$LOG_FILE"
}

emitir_alertas() {
    if [ "$CPU_USO" -ge 80 ]; then
        echo "[ALERTA] Uso de CPU acima de 80%."
        echo "[ALERTA] Uso de CPU acima de 80% em $DATA_HORA" >> "$LOG_FILE"
    else
        echo "[OK] Uso de CPU dentro do limite."
        echo "[OK] CPU dentro do limite em $DATA_HORA" >> "$LOG_FILE"
    fi

    if [ "$MEMORIA_USO" -ge 80 ]; then
        echo "[ALERTA] Uso de memória acima de 80%."
        echo "[ALERTA] Uso de memória acima de 80% em $DATA_HORA" >> "$LOG_FILE"
    else
        echo "[OK] Uso de memória dentro do limite."
        echo "[OK] Memória dentro do limite em $DATA_HORA" >> "$LOG_FILE"
    fi

    if [ "$DISCO_USO" -ge 80 ]; then
        echo "[ALERTA] Uso de disco acima de 80%."
        echo "[ALERTA] Uso de disco acima de 80% em $DATA_HORA" >> "$LOG_FILE"
    else
        echo "[OK] Uso de disco dentro do limite."
        echo "[OK] Disco dentro do limite em $DATA_HORA" >> "$LOG_FILE"
    fi

    if [ "$APACHE_STATUS" = "em execução" ]; then
        echo "[OK] Apache em execução."
        echo "[OK] Apache em execução em $DATA_HORA" >> "$LOG_FILE"
    else
        echo "[ALERTA] Apache não está em execução."
        echo "[ALERTA] Apache parado em $DATA_HORA" >> "$LOG_FILE"
    fi

    echo "" >> "$LOG_FILE"
}

criar_diretorio_log
calcular_cpu
verificar_memoria
verificar_disco
verificar_apache
exibir_monitoramento
emitir_alertas
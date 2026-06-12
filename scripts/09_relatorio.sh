#!/bin/bash

# Script 09 - Relatório operacional automatizado
# Tema: Infraestrutura para um Pequeno E-Commerce
# Aluno: Vinícius Minas

PROJETO="Trabalho 03 - Linux, Shell Script e Cloud Computing"
TEMA="Infraestrutura para um Pequeno E-Commerce"
ALUNO="Vinícius Minas"

LOG_DIR="/app/logs"
RELATORIO="$LOG_DIR/relatorio_execucao.txt"
BASE_DIR="/app/ecommerce"
BACKUP_DIR="/app/backups"
PUBLICACAO="/var/www/html"
USUARIO="pedido_user"
GRUPO="ecommerce_ops"

criar_diretorio_log() {
    mkdir -p "$LOG_DIR"
}

cabecalho_relatorio() {
    echo "===== RELATÓRIO OPERACIONAL AUTOMATIZADO =====" > "$RELATORIO"
    echo "Data/Hora: $(date)" >> "$RELATORIO"
    echo "Projeto: $PROJETO" >> "$RELATORIO"
    echo "Tema: $TEMA" >> "$RELATORIO"
    echo "Aluno: $ALUNO" >> "$RELATORIO"
    echo "================================================" >> "$RELATORIO"
    echo "" >> "$RELATORIO"
}

informar_disco() {
    echo "===== ESPAÇO EM DISCO =====" >> "$RELATORIO"
    df -h >> "$RELATORIO"
    echo "" >> "$RELATORIO"
}

informar_uso_diretorios() {
    echo "===== USO DOS DIRETÓRIOS =====" >> "$RELATORIO"

    if [ -d "$BASE_DIR" ]; then
        du -sh "$BASE_DIR"/* >> "$RELATORIO" 2>/dev/null
    else
        echo "Diretório $BASE_DIR não encontrado." >> "$RELATORIO"
    fi

    echo "" >> "$RELATORIO"
}

informar_status_apache() {
    echo "===== STATUS DO APACHE =====" >> "$RELATORIO"

    if pgrep -f "apache2|apachectl" > /dev/null 2>&1; then
        echo "Apache em execução." >> "$RELATORIO"
    else
        echo "Apache parado." >> "$RELATORIO"
    fi

    apache2 -v >> "$RELATORIO" 2>&1
    echo "" >> "$RELATORIO"
}

listar_backups() {
    echo "===== ÚLTIMOS BACKUPS =====" >> "$RELATORIO"

    if [ -d "$BACKUP_DIR" ]; then
        ls -lh "$BACKUP_DIR" >> "$RELATORIO"
    else
        echo "Diretório de backups não encontrado." >> "$RELATORIO"
    fi

    echo "" >> "$RELATORIO"
}

listar_logs() {
    echo "===== LOGS GERADOS =====" >> "$RELATORIO"

    if [ -d "$LOG_DIR" ]; then
        ls -lh "$LOG_DIR" >> "$RELATORIO"
    else
        echo "Diretório de logs não encontrado." >> "$RELATORIO"
    fi

    echo "" >> "$RELATORIO"
}

listar_publicacao() {
    echo "===== ARQUIVOS PUBLICADOS NO APACHE =====" >> "$RELATORIO"

    if [ -d "$PUBLICACAO" ]; then
        ls -lh "$PUBLICACAO" >> "$RELATORIO"
    else
        echo "Diretório de publicação não encontrado." >> "$RELATORIO"
    fi

    echo "" >> "$RELATORIO"
}

listar_usuarios_permissoes() {
    echo "===== USUÁRIOS E PERMISSÕES =====" >> "$RELATORIO"

    echo "Grupo configurado: $GRUPO" >> "$RELATORIO"
    getent group "$GRUPO" >> "$RELATORIO" 2>&1

    echo "" >> "$RELATORIO"
    echo "Usuário configurado: $USUARIO" >> "$RELATORIO"
    id "$USUARIO" >> "$RELATORIO" 2>&1

    echo "" >> "$RELATORIO"
    echo "Permissões dos diretórios principais:" >> "$RELATORIO"
    ls -ld "$BASE_DIR/pedidos" >> "$RELATORIO" 2>&1
    ls -ld "$BASE_DIR/produtos" >> "$RELATORIO" 2>&1
    ls -ld "$BASE_DIR/clientes" >> "$RELATORIO" 2>&1

    echo "" >> "$RELATORIO"
}

exibir_resultado() {
    echo "Relatório operacional gerado com sucesso."
    echo "Arquivo: $RELATORIO"
    echo ""
    echo "Prévia do relatório:"
    echo "----------------------------------------"
    cat "$RELATORIO"
    echo "----------------------------------------"
}

criar_diretorio_log
cabecalho_relatorio
informar_disco
informar_uso_diretorios
informar_status_apache
listar_backups
listar_logs
listar_publicacao
listar_usuarios_permissoes
exibir_resultado
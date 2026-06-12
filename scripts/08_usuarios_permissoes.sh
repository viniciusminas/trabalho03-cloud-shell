#!/bin/bash

# Script 08 - Usuários, grupos e permissões
# Tema: Infraestrutura para um Pequeno E-Commerce
# Aluno: Vinícius Minas

GRUPO="ecommerce_ops"
USUARIO="pedido_user"
BASE_DIR="/app/ecommerce"
DIRETORIO_PEDIDOS="$BASE_DIR/pedidos"
DIRETORIO_PRODUTOS="$BASE_DIR/produtos"
DIRETORIO_CLIENTES="$BASE_DIR/clientes"
LOG_DIR="/app/logs"
LOG_FILE="$LOG_DIR/08_usuarios_permissoes.log"

criar_diretorio_log() {
    mkdir -p "$LOG_DIR"
}

validar_estrutura() {
    if [ ! -d "$BASE_DIR" ]; then
        echo "Estrutura do e-commerce não encontrada."
        echo "Execute primeiro o script 03_estrutura.sh."
        echo "[ERRO] Estrutura não encontrada em $(date)" >> "$LOG_FILE"
        exit 1
    fi
}

criar_grupo() {
    if getent group "$GRUPO" > /dev/null; then
        echo "Grupo $GRUPO já existe."
        echo "[INFO] Grupo $GRUPO já existia em $(date)" >> "$LOG_FILE"
    else
        groupadd "$GRUPO"
        echo "Grupo $GRUPO criado com sucesso."
        echo "[SUCESSO] Grupo $GRUPO criado em $(date)" >> "$LOG_FILE"
    fi
}

criar_usuario() {
    if id "$USUARIO" > /dev/null 2>&1; then
        echo "Usuário $USUARIO já existe."
        echo "[INFO] Usuário $USUARIO já existia em $(date)" >> "$LOG_FILE"
    else
        useradd -r -g "$GRUPO" -d "$DIRETORIO_PEDIDOS" -s /usr/sbin/nologin "$USUARIO"
        echo "Usuário de sistema $USUARIO criado com sucesso."
        echo "[SUCESSO] Usuário $USUARIO criado em $(date)" >> "$LOG_FILE"
    fi
}

aplicar_permissoes() {
    echo "Aplicando permissões nos diretórios do e-commerce..."

    chown -R "$USUARIO:$GRUPO" "$DIRETORIO_PEDIDOS"
    chmod 750 "$DIRETORIO_PEDIDOS"

    chown -R "root:$GRUPO" "$DIRETORIO_PRODUTOS"
    chmod 755 "$DIRETORIO_PRODUTOS"

    chown -R "root:$GRUPO" "$DIRETORIO_CLIENTES"
    chmod 750 "$DIRETORIO_CLIENTES"

    echo "Permissões aplicadas com sucesso."
    echo "[SUCESSO] Permissões aplicadas em $(date)" >> "$LOG_FILE"
}

exibir_resultado() {
    echo "===== USUÁRIOS, GRUPOS E PERMISSÕES ====="
    echo "Grupo criado/configurado: $GRUPO"
    echo "Usuário criado/configurado: $USUARIO"
    echo ""
    echo "Diretórios principais:"
    ls -ld "$DIRETORIO_PEDIDOS"
    ls -ld "$DIRETORIO_PRODUTOS"
    ls -ld "$DIRETORIO_CLIENTES"
    echo ""
    echo "Registro do usuário:"
    id "$USUARIO"
    echo "=========================================="

    echo "===== RESULTADO DE PERMISSÕES =====" >> "$LOG_FILE"
    ls -ld "$DIRETORIO_PEDIDOS" >> "$LOG_FILE"
    ls -ld "$DIRETORIO_PRODUTOS" >> "$LOG_FILE"
    ls -ld "$DIRETORIO_CLIENTES" >> "$LOG_FILE"
    id "$USUARIO" >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
}

criar_diretorio_log
validar_estrutura
criar_grupo
criar_usuario
aplicar_permissoes
exibir_resultado
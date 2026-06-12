#!/bin/bash

# Script Extra - Menu principal
# Tema: Infraestrutura para um Pequeno E-Commerce
# Aluno: Vinícius Minas
# Instituição: Unidavi

SCRIPTS_DIR="/app/scripts"

pausar() {
    echo ""
    read -p "Pressione ENTER para continuar..."
}

executar_script() {
    SCRIPT="$1"

    if [ -f "$SCRIPTS_DIR/$SCRIPT" ]; then
        chmod +x "$SCRIPTS_DIR/$SCRIPT"
        "$SCRIPTS_DIR/$SCRIPT"
    else
        echo "Script $SCRIPT não encontrado."
    fi

    pausar
}

menu_processos() {
    clear
    echo "===== GERENCIAMENTO DE PROCESSOS ====="
    echo "1 - Listar processos"
    echo "2 - Buscar processo Apache"
    echo "3 - Testar encerramento sem PID"
    echo "0 - Voltar"
    echo "======================================"
    read -p "Escolha uma opção: " OP_PROCESSO

    case "$OP_PROCESSO" in
        1)
            "$SCRIPTS_DIR/06_processos.sh" listar
            ;;
        2)
            "$SCRIPTS_DIR/06_processos.sh" buscar apache
            ;;
        3)
            "$SCRIPTS_DIR/06_processos.sh" matar
            ;;
        0)
            return
            ;;
        *)
            echo "Opção inválida."
            ;;
    esac

    pausar
}

exibir_menu() {
    clear
    echo "Criado por: Vinícius Minas"
    echo "Instituição: Unidavi"
    echo "Tema: Infraestrutura para um Pequeno E-Commerce"
    echo ""
    echo "===== MENU DEVOPS CLOUD ====="
    echo "1 - Atualizar sistema"
    echo "2 - Instalar Apache"
    echo "3 - Criar estrutura do projeto"
    echo "4 - Realizar backup"
    echo "5 - Fazer deploy"
    echo "6 - Ver processos"
    echo "7 - Monitorar sistema"
    echo "8 - Configurar usuários e permissões"
    echo "9 - Gerar relatório"
    echo "0 - Sair"
    echo "============================="
}

while true; do
    exibir_menu
    read -p "Escolha uma opção: " OPCAO

    case "$OPCAO" in
        1)
            executar_script "01_update.sh"
            ;;
        2)
            executar_script "02_apache.sh"
            ;;
        3)
            executar_script "03_estrutura.sh"
            ;;
        4)
            executar_script "04_backup.sh"
            ;;
        5)
            executar_script "05_deploy.sh"
            ;;
        6)
            menu_processos
            ;;
        7)
            executar_script "07_monitoramento.sh"
            ;;
        8)
            executar_script "08_usuarios_permissoes.sh"
            ;;
        9)
            executar_script "09_relatorio.sh"
            ;;
        0)
            echo "Saindo do menu DevOps Cloud..."
            exit 0
            ;;
        *)
            echo "Opção inválida. Tente novamente."
            pausar
            ;;
    esac
done
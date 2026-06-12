# Trabalho 03 - Linux, Shell Script e Cloud Computing

## Aluno

Vinícius Minas

## Instituição

Unidavi

## Tema

Infraestrutura para um Pequeno E-Commerce

## Descrição do Projeto

Este projeto simula a preparação e a administração operacional de um ambiente Linux utilizado por um pequeno e-commerce fictício chamado **Minas Store**.

O ambiente foi estruturado com Docker, utilizando um container baseado em Ubuntu com Apache instalado. A proposta é representar uma rotina básica de DevOps em um cenário cloud, contemplando atualização do sistema, instalação e validação de serviço web, criação de estrutura temática de diretórios, backup, deploy de site estático, gerenciamento de processos, monitoramento, usuários, permissões, logs e relatório operacional.

O site estático do Minas Store é publicado no Apache por meio de script Shell, a partir dos arquivos localizados na pasta `source/`.

## Tecnologias Utilizadas

- Linux Ubuntu
- Docker
- Docker Compose
- Apache HTTP Server
- Shell Script
- HTML
- CSS
- GitHub
- DockerHub

## Estrutura do Projeto

```text
trabalho03-cloud-shell/
├── Dockerfile
├── docker-compose.yml
├── README.md
├── scripts/
│   ├── 01_update.sh
│   ├── 02_apache.sh
│   ├── 03_estrutura.sh
│   ├── 04_backup.sh
│   ├── 05_deploy.sh
│   ├── 06_processos.sh
│   ├── 07_monitoramento.sh
│   ├── 08_usuarios_permissoes.sh
│   ├── 09_relatorio.sh
│   └── menu.sh
├── source/
│   ├── index.html
│   ├── sobre.html
│   └── assets/
├── backups/
├── ecommerce/
├── logs/
└── evidencias/
```

## Descrição das Pastas

| Pasta | Descrição |
|---|---|
| `scripts/` | Contém os scripts Shell responsáveis pela automação operacional do ambiente. |
| `source/` | Contém os arquivos estáticos do site do e-commerce. |
| `source/assets/` | Contém arquivos de estilo e imagens utilizadas pelo site. |
| `backups/` | Diretório onde são armazenados os backups gerados em formato `.tar.gz`. |
| `ecommerce/` | Estrutura temática criada para simular áreas operacionais do e-commerce. |
| `logs/` | Contém os logs gerados pelos scripts e o relatório operacional final. |
| `evidencias/` | Contém prints de execução e validação do ambiente. |

## Estrutura Temática do E-Commerce

O script `03_estrutura.sh` cria a estrutura operacional do e-commerce em `/app/ecommerce`.

```text
/app/ecommerce/
├── backups/
├── clientes/
├── dados/
├── logs/
├── pedidos/
├── produtos/
└── publicacao/
```

Essa estrutura representa áreas comuns de um pequeno e-commerce, como produtos, pedidos, clientes, dados operacionais, logs, backups e publicação.

## Como Executar o Projeto

### 1. Clonar o repositório

```bash
git clone https://github.com/viniciusminas/trabalho03-cloud-shell
cd trabalho03-cloud-shell
```

### 2. Construir e iniciar o container

```bash
docker compose up -d --build
```

### 3. Verificar se o container está em execução

```bash
docker ps
```

O container esperado é:

```text
trabalho03-linux
```

### 4. Acessar o container

```bash
docker exec -it trabalho03-linux bash
```

### 5. Entrar na pasta dos scripts

```bash
cd /app/scripts
```

### 6. Aplicar permissão de execução

```bash
chmod +x *.sh
```

## Como Acessar o Apache no Navegador

Após subir o container, o Apache estará disponível em:

```text
http://localhost:8080
```

Inicialmente, o Apache pode exibir a página padrão. Para publicar o site da Minas Store, execute o script de deploy:

```bash
cd /app/scripts
./05_deploy.sh
```

Depois, atualize o navegador em:

```text
http://localhost:8080
```

## Scripts Disponíveis

| Script | Finalidade |
|---|---|
| `01_update.sh` | Atualiza os pacotes do sistema com `apt update` e `apt upgrade`. |
| `02_apache.sh` | Instala, valida e exibe a versão do Apache. |
| `03_estrutura.sh` | Cria a estrutura temática de diretórios do e-commerce. |
| `04_backup.sh` | Gera backup compactado `.tar.gz` da estrutura do e-commerce. |
| `05_deploy.sh` | Publica os arquivos da pasta `source/` no diretório `/var/www/html`. |
| `06_processos.sh` | Lista, busca e controla processos ativos no ambiente Linux. |
| `07_monitoramento.sh` | Exibe uso de CPU, memória, disco e status do Apache. |
| `08_usuarios_permissoes.sh` | Cria grupo, usuário de sistema e aplica permissões nos diretórios. |
| `09_relatorio.sh` | Gera relatório operacional automatizado em `logs/relatorio_execucao.txt`. |
| `menu.sh` | Menu principal para executar as principais rotinas do projeto. |

## Como Executar Cada Script

### Atualização do sistema

```bash
./01_update.sh
```

### Instalação e validação do Apache

```bash
./02_apache.sh
```

### Criação da estrutura temática

```bash
./03_estrutura.sh
```

### Backup automatizado

```bash
./04_backup.sh
```

O backup é gerado em:

```text
/app/backups/
```

Exemplo de nome gerado:

```text
backup_ecommerce_2026-06-10_23-08-14.tar.gz
```

### Deploy do site estático

```bash
./05_deploy.sh
```

Os arquivos são copiados de:

```text
/app/source
```

para:

```text
/var/www/html
```

### Gerenciamento de processos

Listar processos:

```bash
./06_processos.sh listar
```

Buscar processo pelo nome:

```bash
./06_processos.sh buscar apache
```

Testar encerramento sem informar PID:

```bash
./06_processos.sh matar
```

Encerrar processo por PID:

```bash
./06_processos.sh matar <PID>
```

O script impede encerramento sem PID informado e bloqueia o encerramento do PID 1 por segurança.

### Monitoramento do sistema

```bash
./07_monitoramento.sh
```

O script exibe:

- uso de CPU;
- uso de memória RAM;
- uso de disco;
- status do Apache;
- alertas operacionais.

### Usuários, grupos e permissões

```bash
./08_usuarios_permissoes.sh
```

O script cria/configura:

```text
Grupo: ecommerce_ops
Usuário: pedido_user
```

Também aplica permissões em diretórios específicos do e-commerce utilizando `chown` e `chmod`, sem uso de `chmod 777`.

### Relatório operacional

```bash
./09_relatorio.sh
```

O relatório é salvo em:

```text
/app/logs/relatorio_execucao.txt
```

## Como Executar o Menu Principal

O menu principal centraliza a execução das rotinas do projeto.

```bash
cd /app/scripts
chmod +x menu.sh
./menu.sh
```

O menu apresenta as seguintes opções:

```text
1 - Atualizar sistema
2 - Instalar Apache
3 - Criar estrutura do projeto
4 - Realizar backup
5 - Fazer deploy
6 - Ver processos
7 - Monitorar sistema
8 - Configurar usuários e permissões
9 - Gerar relatório
0 - Sair
```

## Logs Gerados

Os scripts registram logs na pasta:

```text
/app/logs/
```

Exemplos de arquivos gerados:

```text
01_update.log
02_apache.log
03_estrutura.log
04_backup.log
05_deploy.log
06_processos.log
07_monitoramento.log
08_usuarios_permissoes.log
relatorio_execucao.txt
```

## Evidências de Funcionamento

As evidências foram registradas na pasta `evidencias/`, demonstrando:

- container em execução;
- volume Docker configurado;
- scripts com permissão de execução;
- execução do script de atualização;
- instalação e validação do Apache;
- estrutura de diretórios criada;
- backup `.tar.gz` gerado;
- deploy realizado para `/var/www/html`;
- site acessível no navegador;
- monitoramento do sistema;
- usuários e permissões configurados;
- relatório final gerado;
- menu principal;
- imagem publicada no DockerHub.

## DockerHub

A imagem Docker do projeto será publicada no DockerHub.

```text
Link da imagem: https://hub.docker.com/r/vminas/trabalho03-cloud-shell
```

Comando sugerido para baixar a imagem após publicação:

```bash
docker pull vminas/trabalho03-cloud-shell:latest
```

## GitHub

Repositório do projeto:

```text
https://github.com/viniciusminas/trabalho03-cloud-shell
```

## Principais Dificuldades Encontradas

Durante o desenvolvimento, as principais dificuldades foram relacionadas à diferença entre executar comandos no PowerShell do Windows e executar comandos dentro do container Linux. Comandos como `chmod`, `ls -la` e a execução de arquivos `.sh` precisam ser realizados dentro do ambiente Linux.

Também foi necessário ajustar o deploy do site para substituir a página padrão do Apache, garantindo que os arquivos da pasta `source/` fossem publicados corretamente em `/var/www/html`.

Outra dificuldade foi a organização das evidências, pois o trabalho exige prints específicos para comprovar cada etapa operacional executada no ambiente.

## Uso de Inteligência Artificial

Foi utilizada inteligência artificial como apoio para organização do projeto, revisão dos scripts, explicação de erros, melhoria da documentação e apoio na estruturação do README como fora solicitado.

Os comandos foram executados manualmente no ambiente Docker, e os resultados foram validados por meio de logs, testes no terminal, acesso ao Apache pelo navegador e registros na pasta `evidencias/`.

O uso da IA foi feito como ferramenta de apoio ao desenvolvimento e à revisão do projeto.

## Comandos de Teste para Avaliação

Sequência recomendada para validação do projeto:

```bash
git clone https://github.com/viniciusminas/trabalho03-cloud-shell
cd trabalho03-cloud-shell
docker compose up -d --build
docker ps
docker exec -it trabalho03-linux bash
cd /app/scripts
chmod +x *.sh
./menu.sh
```

Também é possível executar os scripts individualmente:

```bash
./01_update.sh
./02_apache.sh
./03_estrutura.sh
./04_backup.sh
./05_deploy.sh
./06_processos.sh listar
./06_processos.sh buscar apache
./07_monitoramento.sh
./08_usuarios_permissoes.sh
./09_relatorio.sh
```

O site pode ser validado em:

```text
http://localhost:8080
```

## Observações Finais

Este projeto representa uma simulação prática de rotinas operacionais comuns em ambientes de infraestrutura e cloud computing. A proposta foi organizar um ambiente Linux containerizado com Apache e automatizar tarefas administrativas utilizando Shell Script.

A adaptação ao tema foi aplicada nos nomes de diretórios, usuários, grupos, logs, relatório, site estático e documentação, mantendo o cenário relacionado à infraestrutura de um pequeno e-commerce.

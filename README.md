# legendary-robot

Atualizar.sh criar um apelido para o comando update


# Legendary Robot

Legendary Robot é uma ferramenta multi-criador que fornece uma interface simples para executar uma série de comandos de atualização e instalação no seu sistema. Este README fornece instruções sobre como usar o Legendary Robot e os comandos que ele suporta.

## Funcionalidades

O Legendary Robot permite executar as seguintes tarefas:

1. **Atualizar e fazer upgrade do sistema**: Atualiza a lista de pacotes e realiza um upgrade do sistema.
2. **Instalar Htop**: Instala a ferramenta de monitoramento de processos Htop.
3. **Instalar Docker**: Instala o Docker, uma plataforma para desenvolvimento, envio e execução de aplicativos em containers.
4. **Instalar Portainer**: Instala o Portainer, uma interface de gerenciamento de containers Docker.
5. **Instalar Ollama (normal)**: Instala o Ollama, uma ferramenta específica (detalhes adicionais podem ser necessários).
6. **Instalar Ollama (via Docker)**: Instala o Ollama usando um container Docker.
7. **Instalar Meta Llama 3**: Instala o Meta Llama 3, uma ferramenta específica (detalhes adicionais podem ser necessários).
8. **Ver CPU Scaling Disponíveis**: Exibe as opções disponíveis para escalonamento de CPU.
9. **Escolher CPU Scaling**: Permite escolher uma opção de escalonamento de CPU.
10. **Baixar Arquivo, Descompactar e Criar Script**: Faz o download de um arquivo, descompacta-o e cria um script.

## Pré-requisitos

Antes de utilizar o Legendary Robot, certifique-se de que seu sistema atenda aos seguintes pré-requisitos:

- Sistema operacional Linux (preferencialmente uma distribuição baseada em Debian/Ubuntu)
- Permissões de superusuário (root) para instalar pacotes e realizar atualizações

## Instalação

Para instalar o Legendary Robot, siga estas etapas:

1. Clone este repositório para o seu diretório local:
    ```sh
    git clone https://github.com/seu-usuario/legendary-robot.git
    ```
2. Navegue até o diretório do projeto:
    ```sh
    cd legendary-robot
    ```
3. Torne o script executável:
    ```sh
    chmod +x legendary-robot.sh
    ```

## Uso

Execute o script `legendary-robot.sh` para iniciar a interface de comando:

```sh
./legendary-robot.sh

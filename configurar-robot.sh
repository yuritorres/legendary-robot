#!/bin/bash

# Funções
atualizar() {
    sudo apt-get update
}

instalar_htop() {
    sudo apt-get install -y htop
}

instalar_docker() {
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl start docker
    sudo systemctl enable docker
}

instalar_docker_debian() {
    # Adicionar a chave GPG oficial do Docker:
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Adicionar o repositório ao sources.list do Apt:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl start docker
    sudo systemctl enable docker
}

instalar_portainer() {
    docker volume create portainer_data
    docker run -d -p 8000:8000 -p 9443:9443 --name=portainer --restart=always \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v portainer_data:/data portainer/portainer-ce:latest
}

instalar_ollama_normal() {
    echo "Instalando Ollama (normal)..."
    # Comando real de instalação para Ollama normal
}

instalar_ollama_docker() {
    docker pull ollama/ollama
    docker run -d --name ollama -p 8080:8080 ollama/ollama
}

instalar_meta_llama3() {
    echo "Instalando Meta Llama 3..."
    # Comando real de instalação para Meta Llama 3
}

ver_cpu_scaling() {
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
}

escolher_cpu_scaling() {
    echo "Escolha uma política de CPU scaling:"
    echo "1. performance"
    echo "2. powersave"
    echo "3. ondemand"
    echo "4. conservative"
    echo "5. schedutil"
    read -p "Digite o número da opção desejada: " opcao

    case $opcao in
        1)
            governor="performance"
            ;;
        2)
            governor="powersave"
            ;;
        3)
            governor="ondemand"
            ;;
        4)
            governor="conservative"
            ;;
        5)
            governor="schedutil"
            ;;
        *)
            echo "Opção inválida"
            escolher_cpu_scaling
            return
            ;;
    esac

    for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
        echo $governor | sudo tee $cpu/cpufreq/scaling_governor
    done
}

baixar_arquivo_descompactar() {
    wget -O cpuminer-opt-linux-5.0.40.tar.gz https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.40/cpuminer-opt-linux-5.0.40.tar.gz
    mkdir -p minerar
    tar -xzf cpuminer-opt-linux-5.0.40.tar.gz -C minerar
    echo "#!/bin/sh
while [ 1 ]; do
	./cpuminer-sse2 -a yespowertide  -o stratum+tcps://stratum-na.rplant.xyz:17059 -u THTEJUeBLemc3ujsKDWefENNt1W3spKHfM.S2
	sleep 5
done
" > minerar/minerar.sh
}

menu() {
    echo "Escolha uma opção:"
    echo "1. Atualizar e fazer upgrade do sistema"
    echo "2. Instalar Htop"
    echo "3. Instalar Docker"
    echo "4. Instalar Docker (Debian)"
    echo "5. Instalar Portainer"
    echo "6. Instalar Ollama (normal)"
    echo "7. Instalar Ollama (via Docker)"
    echo "8. Instalar Meta Llama 3"
    echo "9. Ver CPU Scaling Disponíveis"
    echo "10. Escolher CPU Scaling"
    echo "11. Baixar Arquivo, Descompactar e Criar Script"
    echo "12. Sair"
    read -p "Digite o número da opção desejada: " opcao

    case $opcao in
        1)
            atualizar
            ;;
        2)
            instalar_htop
            ;;
        3)
            instalar_docker
            ;;
        4)
            instalar_docker_debian
            ;;
        5)
            instalar_portainer
            ;;
        6)
            instalar_ollama_normal
            ;;
        7)
            instalar_ollama_docker
            ;;
        8)
            instalar_meta_llama3
            ;;
        9)
            ver_cpu_scaling
            ;;
        10)
            escolher_cpu_scaling
            ;;
        11)
            baixar_arquivo_descompactar
            ;;
        12)
            exit 0
            ;;
        *)
            echo "Opção inválida"
            menu
            ;;
    esac
}

if [ "$EUID" -ne 0 ]
  then echo "Por favor, execute como root"
  exit
fi

# Checando se há argumentos
if [ $# -eq 0 ]; then
    menu
else
    case $1 in
        atualizar)
            atualizar
            ;;
        instalar_htop)
            instalar_htop
            ;;
        instalar_docker)
            instalar_docker
            ;;
        instalar_docker_debian)
            instalar_docker_debian
            ;;
        instalar_portainer)
            instalar_portainer
            ;;
        instalar_ollama_normal)
            instalar_ollama_normal
            ;;
        instalar_ollama_docker)
            instalar_ollama_docker
            ;;
        instalar_meta_llama3)
            instalar_meta_llama3
            ;;
        ver_cpu_scaling)
            ver_cpu_scaling
            ;;
        escolher_cpu_scaling)
            escolher_cpu_scaling
            ;;
        baixar_arquivo_descompactar)
            baixar_arquivo_descompactar
            ;;
        *)
            echo "Opção inválida"
            menu
            ;;
    esac
fi

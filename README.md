## Apresentação

[Ir para apresentação](http://bit.ly/docker-hw-pp)

## Instalando o Docker

###### - Linux

```sh
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker $USER
sudo service docker restart
```

###### - Mac ou Windows

Acesse o endereço: [Docker Toolbox](https://github.com/docker/toolbox/releases/latest)

Baixe o arquivo:

- `DockerToolbox-x.x.x.pkg` **(Mac)**
- `DockerToolbox-x.x.x.exe` **(Windows)**

No terminal configure o acesso ao host

```sh
# Iniciando a máquina virtual
docker-machine start default

# Configurando as variáveis de ambiente para acesso do host default
eval "$(docker-machine env default)"
```

## Testando a instalação do Docker

```sh
docker run hello-world
```

Saída:

```
Hello from Docker.
This message shows that your installation appears to be working correctly.
...
..
.
```

Se você viu essa mensagem na saída então seu docker foi instalado corretamente! :)

## Listando imagens baixadas

```sh
docker images
```

Saída:

```
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
hello-world         latest              0a6ba66e537a        5 weeks ago         960 B
ubuntu              latest              cdd474520b8c        6 weeks ago         188 MB
...
..
.
```


## Buscando por imagens no registry

```sh
docker search centos
```

Saída:

```
NAME                                        DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
centos                                      The official build of CentOS.                   1644      [OK]
jdeathe/centos-ssh                          CentOS-6 6.6 x86_64 / EPEL/IUS Repos / Ope...   11                   [OK]
blalor/centos                               Bare-bones base CentOS 6.5 image                9                    [OK]
million12/centos-supervisor                 Base CentOS-7 with supervisord launcher, h...   7                    [OK]
nimmis/java-centos                          This is docker images of CentOS 7 with dif...   7                    [OK]
torusware/speedus-centos                    Always updated official CentOS docker imag...   7                    [OK]
nathonfowlie/centos-jre                     Latest CentOS image with the JRE pre-insta...   3                    [OK]
...
..
.
```

## Baixando uma imagem

```sh
docker pull centos
```

Saída:

```
Using default tag: latest
latest: Pulling from library/centos
fa5be2806d4c: Pull complete
0cd86ce0a197: Downloading [==========================>                        ] 33.51 MB/62.91 MB
e9407f1d4b65: Download complete
c9853740aa05: Download complete
e9fa5d3a0d0e: Download complete
...
..
.
```

## Criando sua própria imagem

1. Faça o download deste repositório [download](https://github.com/netoht/docker-helloworld/archive/master.zip)
1. Entre no diretório baixado

```sh
# Construindo a imagem
docker build -t <hub-user>/docker-helloworld:latest .

# Iniciando um container com a sua imagem
docker run -d -p 8080:5000 -h myserver-1 --name server1 <hub-user>/docker-helloworld:latest
```

Parâmetros do comando `docker run`:

- `-d`: Executa o container em background (daemon)
- `-h`: Nome do host do container
- `-e`: Adiciona uma variável de ambiente no container
- `-p`: Mapeia uma porta específica do host para uma porta do container (host:container)
- `-P`: Mapeia todas as portas do host para todas as portas do container que foram expostas
- `-it`: Interativo com tty (não é recomendado usar com `-d`)
- `--name`: Nome único para o container
- `--rm:`: Indica que o container será deletado quando terminar de executar
- `--expose`: Expõe uma porta ou um intervalo de portas do container
- `--dns`: Adicionar um nameserver para busca de nomes
- `--link`:
- `--volume`:


## Listando as configurações do container

```sh
docker inspect <container-id or name>

docker inspect --format='{{json .HostConfig}}' <container-id or name>
```

## Observando os logs do container

```sh
docker logs <container-id or name>
```

## Observando os processos do container

```sh
docker top <container-id or name>
```

## Compartilhando sua imagem no Docker Hub

1. Acesse o [Docker Hub](http://hub.docker.com)
2. Faça o login
3. Clique em `Menu` > `Create Repository`
4. Preencha as informações de acordo com a imagem abaixo e clique em `Create`:

![Criando repositório](images/create-repository.png)

5\. No terminal:

```sh
# Logando via terminal
docker login

# Enviando nossa imagem para o Docker Hub
docker push <hub-user>/docker-helloworld:latest
```

## Parando um container

```sh
docker ps
CONTAINER ID        IMAGE                   COMMAND             CREATED             STATUS              PORTS                    NAMES
f39077b79e51        netoht/helloworld2:v1   "python app.py"     28 minutes ago      Up 28 minutes       5000/tcp                 db

docker stop f39077b79e51
```

## Removendo um container

```sh
docker ps -a
CONTAINER ID        IMAGE                   COMMAND             CREATED             STATUS              PORTS                    NAMES
f39077b79e51        netoht/helloworld2:v1   "python app.py"     28 minutes ago      Up 28 minutes       5000/tcp                 db

docker rm f39077b79e51
```

## Removendo todos os containers parados

```sh
docker rm $(docker ps -a -q)
```

## Removendo todos os containers parados e em execução

```sh
docker rm -f $(docker ps -a -q)
```

## Listando as variváveis de ambiente de uma imagem

```sh
docker run ubuntu env
```

## Local das imagens no disco

Na máquina `host` onde o `docker daemon` é executado ficam

O diretório `graph` em `/var/lib/docker/` ficam as imagens.

Exemplo: `ls -l /var/lib/docker/graph/<image-id>/`

```sh
# acessando o host
docker-machine ssh default
sudo su -
cd /var/lib/docker

# lista de arquivos do docker no host
ls -l /var/lib/docker/
total 64
drwxr-xr-x    5 root     root          4096 Oct  7 04:16 aufs
drwx------   15 root     root          4096 Nov 23 00:32 containers
drwx------   76 root     root         20480 Nov 22 05:23 graph   <--- 'graph' Significa 'images'
-rw-r--r--    1 root     root         11264 Nov 23 00:32 linkgraph.db
drwxr-x---    3 root     root          4096 Nov 21 18:10 network
-rw-------    1 root     root           662 Nov 22 05:23 repositories-aufs
drwx------    2 root     root          4096 Nov 22 05:23 tmp
drwx------    2 root     root          4096 Oct  7 04:23 trust
drwx------   14 root     root          4096 Nov 22 00:56 volumes

# listando informações de uma imagem
ls -l /var/lib/docker/graph/02b966f5f6bec2de14c7b5e16edc2b550a9c1494f9b6882bb495f69a1749442b/
total 20
-rw-------    1 root     root            71 Nov 22 00:35 checksum
-rw-------    1 root     root          1319 Nov 22 00:35 json
-rw-------    1 root     root             1 Nov 22 00:35 layersize
-rw-------    1 root     root            82 Nov 22 00:35 tar-data.json.gz
-rw-------    1 root     root          1296 Nov 22 00:35 v1Compatibility

# buscando por arquivos de um container
find /var/lib/docker/aufs/mnt -name <container-id>*
/var/lib/docker/aufs/mnt/d7275954378a017059aaa7debd57352093e48cd5c5b0da42d9234bc5ab690a4b
/var/lib/docker/aufs/mnt/d7275954378a017059aaa7debd57352093e48cd5c5b0da42d9234bc5ab690a4b-init

# listando arquivos do container
ls -l /var/lib/docker/aufs/mnt/d7275954378a017059aaa7debd57352093e48cd5c5b0da42d9234bc5ab690a4b
total 76
drwxr-xr-x    2 root     root          4096 Oct 28 04:34 bin
drwxr-xr-x    2 root     root          4096 Apr 10  2014 boot
drwxr-xr-x    4 root     root          4096 Nov 23 01:33 dev
drwxr-xr-x   64 root     root          4096 Nov 23 01:33 etc
drwxr-xr-x    2 root     root          4096 Apr 10  2014 home
drwxr-xr-x   12 root     root          4096 Oct 28 04:34 lib
drwxr-xr-x    2 root     root          4096 Oct 28 04:33 lib64
drwxr-xr-x    2 root     root          4096 Oct 28 04:33 media
drwxr-xr-x    2 root     root          4096 Apr 10  2014 mnt
drwxr-xr-x    2 root     root          4096 Oct 28 04:33 opt
drwxr-xr-x    2 root     root          4096 Apr 10  2014 proc
drwx------    2 root     root          4096 Oct 28 04:34 root
drwxr-xr-x    7 root     root          4096 Oct 28 04:34 run
drwxr-xr-x    2 root     root          4096 Nov 10 00:35 sbin
drwxr-xr-x    2 root     root          4096 Oct 28 04:33 srv
drwxr-xr-x    2 root     root          4096 Mar 13  2014 sys
drwxrwxrwt    2 root     root          4096 Oct 28 04:34 tmp
drwxr-xr-x   11 root     root          4096 Nov 10 00:35 usr
drwxr-xr-x   12 root     root          4096 Nov 10 00:35 var
```

## Extras

- [Documentação Docker](https://docs.docker.com/)
- [Entendendo como funciona o Docker](https://docs.docker.com/engine/introduction/understanding-docker/)
- [Referências do comando docker run](https://docs.docker.com/engine/reference/run/)
- [Referências do arquivo Dockerfile](https://docs.docker.com/engine/reference/builder/)
- [Melhores práticas para criação do Dockerfile](https://docs.docker.com/engine/articles/dockerfile_best-practices/)
- [Criando seus repositórios no Docker Hub](https://docs.docker.com/docker-hub/repos/)
- [Github do Docker Registry (distribution)](https://github.com/docker/distribution)
- [Criando seu próprio Docker Registry Privado](https://docs.docker.com/registry/deploying/)
- [Entendendo como funciona o Docker Compose](https://docs.docker.com/compose/)
- [Referências do arquivo docker-compose.yml](http://docs.docker.com/compose/compose-file/)

## Referências

- https://docs.docker.com/
- http://christianposta.com/slides/docker/generated/day1.html
- http://christianposta.com/slides/docker/generated/day2.html
- http://christianposta.com/slides/docker/generated/day3.html
- http://christianposta.com/slides/docker/generated/day4.html

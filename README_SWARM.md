## Links

- [Entendendo o Docker Swarm](https://docs.docker.com/swarm/)
- [Instalando o docker swarm](https://docs.docker.com/swarm/install-w-machine/)

## Criando uma máquina virtual local

```sh
docker-machine create -d virtualbox local
```

## Criando o swarm

```sh
docker run swarm create

Unable to find image 'swarm:latest' locally
latest: Pulling from library/swarm
2bc79aec8ea0: Pull complete
dc2fb86a875a: Pull complete
435e648d0f23: Pull complete
e16042a92d05: Pull complete
045bd7b00b5b: Pull complete
3caea1253d76: Pull complete
2b4c55187a27: Pull complete
6b40fe7724bd: Pull complete
Digest: sha256:51a30269d3f3aaa04f744280e3c118aea032f6df85b49819aee29d379ac313b5
Status: Downloaded newer image for swarm:latest
641af9d230009586f2388eb270de35c3 # <--- guarde esse token em um local seguro
```

## Criando o swarm manager

```sh
docker-machine create -d virtualbox --swarm --swarm-master --swarm-discovery token://<TOKEN-FROM-ABOVE> swarm-master
```

## Criando dois swarm node

```sh
docker-machine create -d virtualbox --swarm --swarm-discovery token://<TOKEN-FROM-ABOVE> swarm-agent-00

docker-machine create -d virtualbox --swarm --swarm-discovery token://<TOKEN-FROM-ABOVE> swarm-agent-01
```

## Conectando no swarm manager

```sh
# alterando para o swarm, --swarm
eval $(docker-machine env --swarm swarm-master)

# listando as informações do cluster
docker info

# verificando se todos estão utilizando a mesma versão da imagem
docker ps -a

# testando a execução da imagem no swarm
docker run hello-world
```
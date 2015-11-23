# Referências do arquivo Dockerfile - https://docs.docker.com/engine/reference/builder/)
# Melhores práticas para criação do Dockerfile - https://docs.docker.com/engine/articles/dockerfile_best-practices/

FROM ubuntu:latest

MAINTAINER Waldinar Neto <netoht@gmail.com>

# O comando "docker build" irá executar essas instruções:
RUN apt-get update && apt-get install -y \
    python-pip

COPY ./app/ /app/

WORKDIR /app

RUN pip install -r \
    requirements.txt

EXPOSE 5000

# O comando "docker run" irá executar essas instruções:

# A instrução ENTRYPOINT não pode ser sobrescrita pelo comando "docker run"
ENTRYPOINT ["python"]

# A instrução CMD pode ser sobrescrita pelo comando "docker run"
CMD ["app.py"]
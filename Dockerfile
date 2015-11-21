FROM ubuntu:latest

MAINTAINER Waldinar Neto <netoht@gmail.com>

RUN apt-get update && apt-get install -y \
    python-pip

COPY ./app/ /app/

WORKDIR /app

RUN pip install -r \
    requirements.txt

EXPOSE 5000

ENTRYPOINT ["python"]

CMD ["app.py"]
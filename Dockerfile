FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    apache2 \
    procps \
    tar \
    curl \
    vim \
    sudo \
    && apt clean

WORKDIR /app

COPY scripts/ /app/scripts/
COPY source/ /app/source/

RUN chmod +x /app/scripts/*.sh || true

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
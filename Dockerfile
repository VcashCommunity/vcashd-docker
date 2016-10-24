FROM ubuntu:16.04

ENV VCASH_VERSION 713ca8b0a02d010f62cf9d8c1960e5b77559d938

COPY build.sh .
RUN chmod +x build.sh

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-get install -y wget \
    && sh build.sh From_Source \
    && apt-get remove -y software-properties-common build-essential \
    && apt-get auto-remove --purge -y

VOLUME ["/root/.Vcash"]

CMD ["vcashd"]

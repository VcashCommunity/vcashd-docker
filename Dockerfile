FROM ubuntu:16.04

ENV VCASH_VERSION master

COPY build.sh .
RUN chmod +x build.sh

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-get install -y wget \
    && sh build.sh From_Source \
    && apt-get remove -y software-properties-common build-essential \
    && apt-get autoremove -y --purge

VOLUME ["/root/.Vcash"]

CMD ["vcashd"]

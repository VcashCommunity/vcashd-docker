FROM ubuntu:16.04

ENV VCASH_VERSION 01ab1fc1dfa1cac1c05c08d1686ecaa3a15fb7cb

COPY build.sh .
RUN chmod +x build.sh

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-get install -y wget \
        curl \
    && sh build.sh From_Source \
    && apt-get remove -y software-properties-common build-essential \
    && apt-get autoremove -y --purge

VOLUME ["/root/.Vcash"]

COPY rpc.sh .
RUN . rpc.sh

CMD ["vcashd"]

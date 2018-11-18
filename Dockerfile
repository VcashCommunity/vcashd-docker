FROM debian:stretch AS builder

RUN set -ex \
    \
    && apt-get update \
    && apt-get install -y \
       software-properties-common \
       build-essential \
       git \
       wget \
       curl

COPY build.sh .

ENV VCASH_VERSION 0595c877984609e40e04c91e671bd81555a911eb

RUN set -ex \
    \
    && chmod +x build.sh \
    && sh build.sh From_Source





# Final image

FROM gcr.io/distroless/cc

COPY --from=builder /usr/bin/vcashd /bin/

VOLUME ["/home/.Vcash"]

ENTRYPOINT ["vcashd"]

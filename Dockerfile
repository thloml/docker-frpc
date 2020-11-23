FROM alpine:3.12.1
MAINTAINER zhang@gmail.com


ARG frpc_version
ARG arch=amd64
ENV frpc_version=${frpc_version:-0.29.1} \
    frpc_DIR=/usr/local/frpc \
    arch=${arch:-amd64}

RUN set -ex && \
    frpc_latest=https://github.com/fatedier/frp/releases/download/v${frpc_version}/frp_${frpc_version}_linux_${arch}.tar.gz && \
    frpc_latest_filename=frp_${frpc_version}_linux_${arch}.tar.gz && \
    apk add --no-cache  --virtual wget tar && \
    [ ! -d ${frpc_DIR} ] && mkdir -p ${frpc_DIR} && cd ${frpc_DIR} && \
    wget --no-check-certificate -q ${frpc_latest} -O ${frpc_latest_filename} && \
    tar -xzf ${frpc_latest_filename} && \
    mv frp_${frpc_version}_linux_${arch}/frpc ${frpc_DIR}/frpc && \
    rm -rf /var/cache/apk/* ~/.cache ${frpc_DIR}/${frpc_latest_filename} ${frpc_DIR}/frp_${frpc_version}_linux_${arch}

VOLUME /conf

ENTRYPOINT ["/usr/local/frpc/frpc"]

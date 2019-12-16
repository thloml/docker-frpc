FROM alpine:latest
MAINTAINER zhang@gmail.com


ENV frpc_version=0.30.0 \
    frpc_DIR=/usr/local/frpc \
    arch=amd64

RUN set -ex && \
    frpc_latest=https://github.com/fatedier/frp/releases/download/v${frpc_version}/frp_${frpc_version}_linux_${arch}.tar.gz && \
    frpc_latest_filename=frp_${frpc_version}_linux_${arch}.tar.gz && \
    apk add --no-cache pcre bash && \
    apk add --no-cache  --virtual TMP wget tar && \
    [ ! -d ${frpc_DIR} ] && mkdir -p ${frpc_DIR} && cd ${frpc_DIR} && \
    wget --no-check-certificate -q ${frpc_latest} -O ${frpc_latest_filename} && \
    tar xzf ${frpc_latest_filename} && \
    mv frp_${frpc_version}_linux_${arch}/frpc ${frpc_DIR}/frpc && \
    apk --no-cache del TMP && \
    rm -rf /var/cache/apk/* ~/.cache ${frpc_DIR}/${frpc_latest_filename} ${frpc_DIR}/frp_${frpc_version}_linux_${arch}

VOLUME /conf

ENTRYPOINT ["/usr/local/frpc/frpc"]

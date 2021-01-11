FROM arm64v8/ubuntu

ARG GATEWAY_SERVER=localhost
ARG GATEWAY_TYPE=sx1250
ARG GATEWAY_REGION=US915

WORKDIR /build

RUN apt-get update \
    && apt-get install -y git make gcc wget python3

ADD . /build/

RUN make clean all

RUN cd packet_forwarder \
    && ln -fs ../tools/reset_lgw.sh \
    && cp global_conf.json.${GATEWAY_TYPE}.${GATEWAY_REGION} global_conf.json
    && sed -i.bak s/localhost/${MINER_HOST}/g global_conf.json

WORKDIR /build/packet_forwarder

CMD './lora_pkt_fwd'

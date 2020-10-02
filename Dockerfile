FROM arm64v8/ubuntu

WORKDIR /build

RUN apt-get update \
    && apt-get install -y git make gcc wget python3

ADD . /build/

RUN make clean all

RUN cd packet_forwarder \
    && ln -fs ../tools/reset_lgw.sh \
    && ln -fs global_conf.json.sx1250.US915 global_conf.json

WORKDIR /build/packet_forwarder

CMD './lora_pkt_fwd' 

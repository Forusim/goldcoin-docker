FROM ubuntu:latest

ARG DEBIAN_FRONTEND="noninteractive"
ARG BRANCH="main"

ENV keys="generate"
ENV harvester="false"
ENV farmer="false"
ENV plots_dir="/plots"
ENV farmer_address="null"
ENV farmer_port="null"
ENV full_node_port="null"

RUN apt-get update \
 && apt-get install -y tzdata ca-certificates git lsb-release sudo nano

RUN git clone --branch ${BRANCH} https://github.com/goldcoin-gl/gold-blockchain.git --recurse-submodules \
 && cd gold-blockchain \
 && chmod +x install.sh && ./install.sh

ENV PATH=/gold-blockchain/venv/bin/:$PATH

EXPOSE 14444
WORKDIR /gold-blockchain

COPY ./entrypoint.sh entrypoint.sh
ENTRYPOINT ["bash", "./entrypoint.sh"]

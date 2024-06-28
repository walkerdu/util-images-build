FROM ubuntu:22.04

RUN sed -i 's#security.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    sed -i 's#archive.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    apt-get update 
RUN apt-get install -y vim curl git python3 python3-dev pip3

# 默认的shell设置为bash
#SHELL ["/bin/bash", "-c"]

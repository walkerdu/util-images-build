FROM --platform=linux/amd64 ubuntu:22.04


RUN sed -i 's#security.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    sed -i 's#archive.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    apt-get update 
RUN apt-get install -y vim curl git python3 python3-dev python3-pip
RUN pip3 install git+https://github.com/beancount/beancount@v2 pytest fava

EXPOSE 8080

# 默认的shell设置为bash
#SHELL ["/bin/bash", "-c"]

FROM --platform=linux/amd64 ubuntu:24.04


RUN sed -i 's#security.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    sed -i 's#archive.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    apt-get update 
RUN apt-get install -y vim curl git python3 python3-dev python3-pip

# dependency by python2.7.18 compiling
RUN apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev 
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"\
export PATH="$PYENV_ROOT/bin:$PATH"\
eval "$(pyenv init --path)"\
eval "$(pyenv init -)"\
eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc && source ~/.bashrc && pyenv install 2.7.8

ADD walkerdu_repo /data/walkerdu_repo

EXPOSE 8080

# 默认的shell设置为bash
#SHELL ["/bin/bash", "-c"]

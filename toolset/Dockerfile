FROM --platform=linux/amd64 ubuntu:24.04

SHELL ["/bin/bash", "-ic"]
#RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN sed -i 's#security.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    sed -i 's#archive.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    apt-get update 
RUN apt-get install -y vim curl git python3 python3-dev python3-pip python3-venv

# dependency by python2.7.18 compiling
RUN apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev 
RUN curl -fsSL https://pyenv.run | bash
RUN echo -e 'export PYENV_ROOT="$HOME/.pyenv"\n\
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"\n\
eval "$(pyenv init - bash)"\n\
eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
RUN source ~/.bashrc && env && pyenv install 2.7.18 && pyenv global 2.7.18 && pip install pycrypto

ADD walkerdu_repo /data/walkerdu_repo

EXPOSE 8080

# 默认的shell设置为bash
#SHELL ["/bin/bash", "-c"]

FROM ubuntu:22.04

RUN sed -i 's#security.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    sed -i 's#archive.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    apt-get update 
RUN apt-get install -y vim curl git python2

# 默认的shell设置为bash
#SHELL ["/bin/bash", "-c"]

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash 
RUN echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.bashrc && \
    . ~/.bashrc && \
    nvm install v20.10.0 && \
    npm install -g hexo-cli
    
RUN . ~/.bashrc && mkdir /data && cd /data && hexo init homepage && cd homepage && npm install

FROM ubuntu:22.04

# 更换源
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get update

# 直接使用软件源的安装包
RUN apt-get install -y vim wget make git git-lfs python2 python3 passwd lrzsz clang cmake golang openssh-server curl universal-ctags locales fish

# 设置语言环境
RUN locale-gen en_US.UTF-8

# sshd配置
RUN sed -i 's/#Port 22/Port 22\nPort 36000/g' /etc/ssh/sshd_config && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

# vim-plug插件管理器
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 需要源码编译的软件
# https://github.com/Koihik/LuaFormatter
COPY LuaFormatter.tar.gz /tmp
RUN cd /tmp && tar -xf LuaFormatter.tar.gz && cd /tmp/LuaFormatter && cmake . && make -j6 && make install

COPY .bashrc .vimrc /root

COPY localtime /etc/localtime

EXPOSE 36000

#CMD ["/usr/sbin/sshd"]
#CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]

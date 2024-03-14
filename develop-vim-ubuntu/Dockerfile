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
RUN apt-get install -y vim wget make git git-lfs python2 python3 passwd lrzsz clang cmake golang openssh-server

# sshd配置
RUN sed -i 's/#Port 22/Port 22\nPort 36000/g' /etc/ssh/sshd_config && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

# 自动生成密钥文件，不用交互模式创建
RUN ssh-keygen -q -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key 
RUN ssh-keygen -q -t rsa -N ''  -f /etc/ssh/ssh_host_rsa_key
RUN chmod 600 /etc/ssh/ssh_host_dsa_key
RUN chmod 600 /etc/ssh/ssh_host_rsa_key

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/0.10.0/plug.vim
RUN yum install ctags -y

# 需要源码编译的软件
COPY LuaFormatter.tar.gz /tmp
RUN cd /tmp && tar -xf LuaFormatter.tar.gz && cd /tmp/LuaFormatter && cmake . && make -j6 && make install

COPY .bashrc /root
COPY .vimrc /root

COPY localtime /etc/localtime

EXPOSE 36000

#CMD ["/usr/sbin/sshd"]
#CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]

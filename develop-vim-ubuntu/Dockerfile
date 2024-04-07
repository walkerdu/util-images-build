FROM --platform=linux/x86_64 ubuntu:22.04

# 更换源
RUN sed -i 's#security.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    sed -i 's#archive.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    apt-get update 

# 直接使用软件源的安装包
RUN apt-get install -y vim wget make git python2 python2-dev python3 python3-dev passwd lrzsz clang cmake curl universal-ctags locales fish git-lfs openssh-server libreadline-dev nodejs

# sshd配置
RUN sed -i 's/#Port 22/Port 22\nPort 36000/g' /etc/ssh/sshd_config && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

# 安装golang
COPY go1.22.1.linux-amd64.tar.gz /tmp
RUN  rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/go1.22.1.linux-amd64.tar.gz  && rm /tmp/go1.22.1.linux-amd64.tar.gz

# 需要源码编译的软件
# https://github.com/Koihik/LuaFormatter
COPY LuaFormatter.tar.gz /tmp
RUN cd /tmp && tar -xf LuaFormatter.tar.gz && cd /tmp/LuaFormatter && cmake . && make -j6 && make install && rm -rf /tmp/LuaFormatter*

# 编译lua5.3.4
COPY lua-5.3.4.tar.gz /tmp
RUN cd /tmp && tar -xf lua-5.3.4.tar.gz && cd lua-5.3.4 && make linux && make install && rm -rf /tmp/lua-5.3.4*

# vim-plug插件安装
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/0.13.0/plug.vim

COPY .bashrc .vimrc /root
COPY localtime /etc/localtime

# 设置语言环境
RUN locale-gen en_US.UTF-8

#EXPOSE 36000
#CMD ["/usr/sbin/sshd"]
#CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]

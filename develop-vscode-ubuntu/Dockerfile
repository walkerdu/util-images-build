#FROM ubuntu:24.04 
# 使用 Ubuntu 22.04（24.04 默认不提供 python2，如需 python2 请用 22.04）
FROM ubuntu:22.04

# 更换源
RUN sed -i 's#security.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    sed -i 's#archive.ubuntu.com#mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    apt-get update 


# 设置非交互式安装，避免 locale 或 tzdata 弹窗
ENV DEBIAN_FRONTEND=noninteractive TZ=UTC

# 安装所有对应软件包
RUN apt-get install -y --no-install-recommends \
        wget \
        gcc \
        g++ \
        make \
        cmake \
        git \
        git-svn \
        subversion \
        python2 \
        python2-dev \
        python3 \
        python3-dev \
        openssh-server \
        passwd \
        locales \
        lrzsz \
        npm \
        vim \
        libreadline-dev \
        ca-certificates \
        curl && \
    \
    # 安装 git-lfs
    curl -fsSL https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && apt install -y git-lfs

    
# 清理缓存，减小镜像体积
RUN apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#2 编译lua5.3.4
COPY lua-5.3.4.tar.gz /tmp
RUN cd /tmp && tar -xf lua-5.3.4.tar.gz && cd lua-5.3.4 && make linux && make install && rm -rf /tmp/lua-5.3.4*

#3. sshd配置
RUN sed -i 's/#Port 22/Port 22\nPort 36000/g' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config && \
    #sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config && \
    sed -i '/session    required     pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/sshd

#4. 安装go
COPY go1.22.1.linux-amd64.tar.gz /tmp
RUN  rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/go1.22.1.linux-amd64.tar.gz  && rm /tmp/go1.22.1.linux-amd64.tar.gz

# 自动生成密钥文件，不用交互模式创建
# ubuntu openssh安装后会自动生成
#RUN ssh-keygen -q -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key 
#RUN ssh-keygen -q -t rsa -N ''  -f /etc/ssh/ssh_host_rsa_key
#RUN chmod 600 /etc/ssh/ssh_host_dsa_key
#RUN chmod 600 /etc/ssh/ssh_host_rsa_key
#RUN echo '/usr/sbin/sshd' >> /etc/rc.local

#在某些 CentOS/RHEL 的旧版 Docker 镜像（尤其是那些启动了 systemd 或模拟了完整系统的）中，有时会因为 pam 配置或初始化脚本误创建 /run/nologin，导致 docker exec 登录失败。
#RUN rm /run/nologin

# 设置UTC+8时区
COPY localtime /etc/localtime

# vim-plug插件安装
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/0.13.0/plug.vim

# 自定义的bash, vim的配置
COPY .bashrc /root
COPY .vimrc /root

# ubuntu:22.04 默认没有生成任何 UTF-8 locale, 明确生成和设置一个存在的 locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

EXPOSE 36000

# SSH 服务（sshd）在启动时找不到用于 特权分离（privilege separation） 的运行时目录 /run/sshd
RUN mkdir -p /run/sshd
RUN mkdir ~/.ssh/ && touch ~/.ssh/authorized_keys
CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config", "-E", "/tmp/sshd.log"]

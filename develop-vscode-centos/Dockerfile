FROM centos:centos8.4.2105

# yum源加速
#RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.cloud.tencent.com/repo/centos8_base.repo
#RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo 
#COPY centos8_base.repo /etc/yum.repos.d/CentOS-Base.repo
RUN mkdir /etc/yum.repos.d/backup && mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup
ADD http://mirrors.aliyun.com/repo/Centos-8.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum clean all && yum makecache
RUN yum repolist

#1. 直接使用软件源的安装包
#glibc-langpack-en.x86_64 -y     # centos镜像没有安装en的语言包，安装一下否则无法设置en_US.UTF-8的locale
RUN yum install wget gcc gcc-c++.x86_64 make cmake3 git git-svn git-lfs svn python2 python2-devel python3 python3-devel openssh-server.x86_64 glibc-langpack-en.x86_64 passwd lrzsz npm vim readline-devel -y


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
RUN ssh-keygen -q -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key 
RUN ssh-keygen -q -t rsa -N ''  -f /etc/ssh/ssh_host_rsa_key
RUN chmod 600 /etc/ssh/ssh_host_dsa_key
RUN chmod 600 /etc/ssh/ssh_host_rsa_key
#RUN echo '/usr/sbin/sshd' >> /etc/rc.local
RUN rm /run/nologin

# 设置UTC+8时区
COPY localtime /etc/localtime

# vim-plug插件安装
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/0.13.0/plug.vim

# 自定义的bash, vim的配置
COPY .bashrc /root
COPY .vimrc /root

EXPOSE 36000

CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config", "-E", "/tmp/sshd.log"]

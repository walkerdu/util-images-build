FROM centos:centos8.4.2105

# yum源加速
#RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.cloud.tencent.com/repo/centos8_base.repo
#RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo 
#COPY centos8_base.repo /etc/yum.repos.d/CentOS-Base.repo
RUN mkdir /etc/yum.repos.d/backup && mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup
ADD http://mirrors.aliyun.com/repo/Centos-8.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum clean all && yum makecache
RUN yum repolist

# 直接使用软件源的安装包
#glibc-langpack-en.x86_64 -y     # centos镜像没有安装en的语言包，安装一下否则无法设置en_US.UTF-8的locale
RUN yum install wget gcc gcc-c++.x86_64 make cmake3 git git-svn git-lfs svn python2 python2-devel openssh-server.x86_64 go glibc-langpack-en.x86_64 passwd lrzsz clang clang-tools-extra clang-devel ctags npm -y

# 编译Python-3.11.8所需的依赖
RUN yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel libffi-devel gdbm-devel xz-devel

# 编译Python-3.11.8
COPY Python-3.11.8.tgz /tmp
RUN cd /tmp && tar -xf Python-3.11.8.tgz && cd /tmp/Python-3.11.8 && ./configure  --enable-shared --enable-profiling --enable-optimizations LDFLAGS="-Wl,-rpath /usr/local/lib" && make -j6 && make install && rm -rf /tmp/Python-3.11.8*

# 编译LuaFormatter
COPY LuaFormatter.tar.gz /tmp
RUN cd /tmp && tar -xf LuaFormatter.tar.gz && cd /tmp/LuaFormatter && cmake . && make -j6 && make install && rm -rf /tmp/LuaFormatter*

# sshd配置
RUN sed -i 's/#Port 22/Port 22\nPort 36000/g' /etc/ssh/sshd_config && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

# 自动生成密钥文件，不用交互模式创建
RUN ssh-keygen -q -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key 
RUN ssh-keygen -q -t rsa -N ''  -f /etc/ssh/ssh_host_rsa_key
RUN chmod 600 /etc/ssh/ssh_host_dsa_key
RUN chmod 600 /etc/ssh/ssh_host_rsa_key
#RUN echo '/usr/sbin/sshd' >> /etc/rc.local
RUN rm /run/nologin

# 编译vim及其插件所需
RUN yum install ncurses-devel.x86_64 -y

# 编译vim
COPY vim-9.1.0186.tar.gz /tmp
# Python如果编译生产的额是静态库，vim的编译需要链接pthread
#RUN cd /tmp && tar -xf /tmp/vim-9.1.0186.tar.gz && cd /tmp/vim-9.1.0186 && ./configure LIBS="-lpthread" --enable-python3interp && make -j10 && make install && rm -rf /tmp/vim-*
RUN cd /tmp && tar -xf /tmp/vim-9.1.0186.tar.gz && cd /tmp/vim-9.1.0186 && ./configure --enable-python3interp && make -j10 && make install && rm -rf /tmp/vim-*
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/0.13.0/plug.vim
COPY .bashrc /root
COPY .vimrc /root

COPY localtime /etc/localtime

#RUN echo -e 'LANG=en_US.utf-8\nLC_ALL=en_US.utf-8' >> /etc/environment
#RUN echo -e 'LC_ALL=en_US.utf-8' >> /etc/environment

EXPOSE 36000

#CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]

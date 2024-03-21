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
RUN yum install wget gcc gcc-c++.x86_64 make cmake3 git git-svn git-lfs svn python2 python2-devel openssh-server.x86_64 glibc-langpack-en.x86_64 passwd lrzsz ctags npm -y

#2. sshd配置
RUN sed -i 's/#Port 22/Port 22\nPort 36000/g' /etc/ssh/sshd_config && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

# 自动生成密钥文件，不用交互模式创建
RUN ssh-keygen -q -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key 
RUN ssh-keygen -q -t rsa -N ''  -f /etc/ssh/ssh_host_rsa_key
RUN chmod 600 /etc/ssh/ssh_host_dsa_key
RUN chmod 600 /etc/ssh/ssh_host_rsa_key
#RUN echo '/usr/sbin/sshd' >> /etc/rc.local
RUN rm /run/nologin

#3. 编译Python-3.11.8
# 编译Python-3.11.8所需的依赖
RUN yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel libffi-devel gdbm-devel xz-devel

COPY Python-3.11.8.tgz /tmp
RUN cd /tmp && tar -xf Python-3.11.8.tgz && cd /tmp/Python-3.11.8 && ./configure  --enable-shared --enable-profiling --enable-optimizations LDFLAGS="-Wl,-rpath /usr/local/lib" && make -j8 && make install && rm -rf /tmp/Python-3.11.8*

#4. 编译clang 17, YCM需要最低的clang 17.0.1的版本
# clang17 编译需要Python3.6以上的版本，所以需要先编译Python
ADD https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.1/llvm-project-17.0.1.src.tar.xz /tmp/
RUN cd /tmp && tar -xf llvm-project-17.0.1.src.tar.xz && cd /tmp/llvm-project-17.0.1.src && mkdir build && cd build && cmake -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../llvm  && make -j8 &&>

#5. 编译LuaFormatter
COPY LuaFormatter.tar.gz /tmp
RUN cd /tmp && tar -xf LuaFormatter.tar.gz && cd /tmp/LuaFormatter && cmake . && make -j8 && make install && rm -rf /tmp/LuaFormatter*

#6. 安装golang, YCM需要高版本
COPY go1.22.1.linux-amd64.tar.gz /tmp
RUN  rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/go1.22.1.linux-amd64.tar.gz  && rm /tmp/go1.22.1.linux-amd64.tar.gz

#7. 编译vim
# 编译vim及其插件所需
RUN yum install ncurses-devel.x86_64 -y

COPY vim-9.1.0186.tar.gz /tmp
# Python如果编译生产的额是静态库，vim的编译需要链接pthread
#RUN cd /tmp && tar -xf /tmp/vim-9.1.0186.tar.gz && cd /tmp/vim-9.1.0186 && ./configure LIBS="-lpthread" --enable-python3interp && make -j10 && make install && rm -rf /tmp/vim-*
RUN cd /tmp && tar -xf /tmp/vim-9.1.0186.tar.gz && cd /tmp/vim-9.1.0186 && ./configure --enable-python3interp && make -j10 && make install && rm -rf /tmp/vim-*
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/0.13.0/plug.vim
COPY .bashrc /root
COPY .vimrc /root

#8. 设置UTC+8时区
COPY localtime /etc/localtime

#RUN echo -e 'LANG=en_US.utf-8\nLC_ALL=en_US.utf-8' >> /etc/environment
#RUN echo -e 'LC_ALL=en_US.utf-8' >> /etc/environment

EXPOSE 36000

#CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]

# autovina 
ARG VERSION=1.0
FROM hotwa/ubuntu:20.04 as autodockvina
LABEL author="hotwa<ze.ga@qq.com>" date="2022-02-10"
LABEL description="autovina environment"
WORKDIR /tmp/config
ENV DIRPATH /tmp/config/
ENV HOME=/home/root/
# replace own RSAPublicKey
COPY ./config/id_rsa.pub $DIRPATH/ 
COPY ./config/python_scripting/* $HOME

RUN mv $DIRPATH/id_rsa.pub /root/.ssh/authorized_keys && \
    apt update && \
    apt install sudo -y && \
    apt install -y python3-pip libboost-all-dev swig && \
    ln -s /usr/bin/python3 /usr/bin/python

RUN mkdir ~/.pip && \
    touch ~/.pip/pip.conf && \
    echo "\
    [global]\n\
        index-url = https://pypi.tuna.tsinghua.edu.cn/simple\n\
    " >> ~/.pip/pip.conf && \
    pip install pip -U && \
    pip install vina

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
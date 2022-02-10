# autovina 
ARG VERSION=1.0
FROM hotwa/vina as autodockvina
LABEL author="hotwa<ze.ga@qq.com>" date="2022-02-10"
LABEL description="autovina environment base on ubuntu 20.04"
WORKDIR /tmp/config
ENV DIRPATH /tmp/config/
# ! replace own RSAPublicKey
COPY ./config/id_rsa.pub $DIRPATH/ 

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
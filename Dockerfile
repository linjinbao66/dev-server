FROM scratch AS builder
ADD rootfs.tar.xz /
CMD ["bash"]


FROM builder

LABEL org.opencontainers.image.authors="linjinbao66@gmail.com"
LABEL org.opencontainers.image.title="dev-server for development kit"
LABEL org.opencontainers.image.content="redis mysql mongo ping nslookup netstat ssh curl wget"

RUN apt update && \
    apt install sudo curl wget gpg gnupg2 iputils-ping dnsutils telnet -y && \
    curl -fsSL https://www.mongodb.org/static/pgp/server-5.0.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-5.gpg && \
    echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list && \
    apt update && \
    apt install mongodb-org-shell default-mysql-client redis-tools net-tools openssh-server -y
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test
RUN echo 'test:test@978' | chpasswd
RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]

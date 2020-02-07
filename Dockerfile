FROM  ubuntu
LABEL maintener="clazar <claudiolazarosantos@gmail.com>"
LABEL version="0.1"
LABEL description="Openconnect for gp in docker - Corporate"

RUN set -ex \
    && apt-get update \
    && apt-get upgrade -y \ 
    && apt-get install -y \
    build-essential gettext autoconf automake libproxy-dev \
    libxml2-dev git curl iptables libxss1 libtool vpnc-scripts \
    pkg-config zlib1g-dev libgnutls28-dev stoken sudo \
    inetutils-ping telnet nano \
## COPIAR DO GITHUB
    && git clone https://github.com/dlenski/openconnect.git /tmp/openconnect-globalprotect \
## INSTALANDO GB 
    && cd /tmp/openconnect-globalprotect \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install && ldconfig\
    && apt-get clean
##RUN groupadd --gid 1000 admin &&
RUN adduser \
    --disabled-password \
    --gecos "" \
    --shell /bin/bash \
    --home /home/admin \
    --uid 1000 \	
    admin && \	
    sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g' && \
    echo "admin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "Customized the sudoers file for passwordless access to the amin user!"

COPY content /home/admin/ 
RUN chown admin:admin /home/admin/connvpn.sh  && chmod +x /home/admin/connvpn.sh 
USER admin
ENTRYPOINT ["/bin/bash"]

FROM mitmproxy/mitmproxy:8.0.0

# Based on artemkloko/docker-mitm-nginx-proxy-companion

RUN apt update && \
    apt install -y \
        wget \
        dnsmasq \
    && rm -rf /var/lib/apt/lists/*

# Install Forego, copied from https://dl.equinox.io/ddollar/forego/stable
COPY forego/forego /usr/local/bin/forego

# Install docker-gen, copied from https://github.com/jwilder/nginx-proxy/blob/master/Dockerfile.alpine
ENV DOCKER_GEN_VERSION 0.7.4
RUN wget --quiet https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

COPY docker-entrypoint.sh /usr/local/bin/

ADD config/dnsmasq.tmpl /etc/dnsmasq.tmpl
ADD config/dnsmasq-reload /usr/local/bin/dnsmasq-reload

ENV CA_DIR ""
ENV CA_CERT ""
ENV CA_KEY ""

ENV HOME "/home/mitmproxy/"
ENV MITMPROXY_PATH "/home/mitmproxy/.mitmproxy"

EXPOSE 53/udp
EXPOSE 8042

WORKDIR "$HOME"
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

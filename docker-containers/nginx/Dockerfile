FROM debian:stretch-slim

RUN useradd --no-create-home nginx

RUN apt-get update && apt-get -y install --no-install-recommends --no-install-suggests \
    wget git ca-certificates build-essential libssl-dev libreadline-dev

RUN mkdir -p ~/tmp && \
    cd ~/tmp && \
    wget http://nginx.org/download/nginx-1.12.2.tar.gz && \
    tar -zxf ~/tmp/nginx-1.12.2.tar.gz -C ~/tmp && \
    wget https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.gz && \
    tar -zxf ~/tmp/pcre-8.44.tar.gz -C ~/tmp && \
    wget http://zlib.net/zlib-1.2.11.tar.gz && \
    tar -zxf ~/tmp/zlib-1.2.11.tar.gz -C ~/tmp && \
    cd ~/tmp/nginx-1.12.2 && \
    ./configure --prefix=/usr --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf \
    --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log \
    --pid-path=/var/run/nginx/nginx.pid --lock-path=/var/lock/nginx.lock \
    --user=nginx --group=nginx \
    --with-http_ssl_module --with-http_gzip_static_module \
    --http-client-body-temp-path=/tmp/nginx/client --http-proxy-temp-path=/tmp/nginx/proxy --http-fastcgi-temp-path=/tmp/nginx/fcgi \
    --with-pcre=../pcre-8.44 --with-zlib=../zlib-1.2.11 --with-http_stub_status_module \
    --add-module=../nginx-push-stream-module && \
    make && \
    make install && \
    make clean && \
    rm -rf ~/tmp

RUN apt-get -y purge \
    wget git ca-certificates build-essential && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/nginx/client /tmp/nginx/proxy /tmp/nginx/fcgi

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

CMD ["nginx"]

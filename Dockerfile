FROM centos:7
MAINTAINER RPM Builder <eva.li@ehealth.com>

RUN yum -y install gcc gcc-c++ git make wget 
RUN wget "http://nginx.org/download/nginx-1.7.8.tar.gz"
RUN wget "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz"
RUN wget "https://www.openssl.org/source/openssl-1.0.1j.tar.gz"
RUN wget "http://zlib.net/zlib-1.2.11.tar.gz"

RUN git clone https://github.com/cuber/ngx_http_google_filter_module
RUN git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module

RUN tar xzvf nginx-1.7.8.tar.gz 
RUN tar xzvf pcre-8.38.tar.gz 
RUN tar xzvf openssl-1.0.1j.tar.gz 
RUN tar xzvf zlib-1.2.11.tar.gz

RUN cd nginx-1.7.8

WORKDIR "/nginx-1.7.8"
RUN ./configure --prefix=/opt/nginx-1.7.8 --with-pcre=../pcre-8.38 --with-openssl=../openssl-1.0.1j --with-zlib=../zlib-1.2.11 --with-http_ssl_module --add-module=../ngx_http_google_filter_module --add-module=../ngx_http_substitutions_filter_module
RUN make
RUN make install

ADD nginx.conf /opt/nginx-1.7.8/conf/nginx.conf

EXPOSE 80

#CMD /opt/nginx-1.7.8/sbin/nginx



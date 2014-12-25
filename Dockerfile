FROM centos:centos7

# Install EPEL7 and update OS
RUN yum install -y epel-release deltarpm && yum update -y && yum groups mark convert
# Install CentOS Components and related libs for development
#     zlib-devel openssl-devel pcre-devel: for uwsgi, python3
RUN yum groups mark convert && \
    yum groupinstall -y "Development Tools" && \
    yum install -y zlib-devel openssl-devel pcre-devel
# Install supervisor, and nginx
RUN yum install -y nginx supervisor && echo "daemon off;" >> /etc/nginx/nginx.conf
# Install Python 2.7
RUN yum install -y python-virtualenv python-setuptools python-devel python-pip && \
    pip install --upgrade pip setuptools
# Install Python 3.4
RUN curl -sO https://www.python.org/ftp/python/3.4.2/Python-3.4.2.tgz && \
    tar xf Python-3.4.2.tgz && \
    cd Python-3.4.2 && \
    ./configure --prefix=/usr/local --enable-shared && \
    make && \
    make install && \
    cd .. && rm -rf Python-3.4.2* && \
    echo /usr/local/lib >> /etc/ld.so.conf.d/local.conf && \
    ldconfig && \
    pip3.4 install --upgrade pip setuptools && \
    pip3.4 install virtualenv
# Install uwsgi
RUN pip3.4 install uwsgi

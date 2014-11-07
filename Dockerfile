FROM centos:centos7

# Install EPEL7 and update OS
# Install CentOS Components for development
# Install Python, supervisor, nginx, and related libs
#     python-virtualenv python-setuptools: Virtualenv basic
#     python-devel: for packages compiled from C
#     zlib-devel openssl-devel pcre-devel: for uwsgi
#     ImageMagick-devel: for Python: Wand
RUN yum install -y epel-release deltarpm && \
    yum update -y && \
    yum groups mark convert && \
    yum groupinstall -y "Development Tools" && \
    yum install -y \
    python-virtualenv python-setuptools python-devel zlib-devel openssl-devel pcre-devel ImageMagick-devel \
    nginx supervisor && \
    easy_install pip && pip install --upgrade pip setuptools && \
    echo "daemon off;" >> /etc/nginx/nginx.conf && \
    pip install uwsgi

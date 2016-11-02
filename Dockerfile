# sshd
#
# VERSION               0.0.2

FROM     gendosu/ubuntu-base:latest
#FROM     docker-ubuntu-ruby:base

MAINTAINER Gen Takahashi "gendosu@gmail.com"

ENV PATH /usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv
ENV RUBY_VERSION 2.3.0
ENV CONFIGURE_OPTS --disable-install-doc

RUN apt-get update \
&&  apt-get install -y \
    git \
    libssl-dev \
    libreadline-dev \
    imagemagick \
    libmagick++-dev \
    libqtwebkit-dev \
    xvfb \
    libffi-dev \
    mysql-client \
    libmysqlclient-dev \
    libssl-dev \
    libffi-dev \
&&  apt-get clean \
&&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN git clone --depth 1 git://github.com/sstephenson/rbenv.git ${RBENV_ROOT} \
&&  git clone --depth 1 https://github.com/sstephenson/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build \
&&  git clone --depth 1 git://github.com/jf/rbenv-gemset.git ${RBENV_ROOT}/plugins/rbenv-gemset \
&&  ${RBENV_ROOT}/plugins/ruby-build/install.sh

RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh \
&&  echo 'eval "$(rbenv init -)"' >> /root/.bashrc

RUN rbenv install $RUBY_VERSION \
&&  rbenv global $RUBY_VERSION

# RUN eval "$(rbenv init -)"; gem install bundler
# 

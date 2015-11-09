# sshd
#
# VERSION               0.0.2

FROM     gendosu/ubuntu-base:latest

MAINTAINER Gen Takahashi "gendosu@gmail.com"

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

RUN git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv \
&&  git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build \
&&  git clone git://github.com/jf/rbenv-gemset.git /usr/local/rbenv/plugins/rbenv-gemset \
&&  /usr/local/rbenv/plugins/ruby-build/install.sh
ENV PATH /usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh \
&&  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh \
&&  echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc \
&&  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /root/.bashrc \
&&  echo 'eval "$(rbenv init -)"' >> /root/.bashrc

ENV CONFIGURE_OPTS --disable-install-doc

RUN eval "$(rbenv init -)"; rbenv install 2.0.0-p647 \
&&  eval "$(rbenv init -)"; rbenv global 2.0.0-p647

RUN eval "$(rbenv init -)"; gem install bundler


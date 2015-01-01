# sshd
#
# VERSION               0.0.1

FROM     gendosu/ubuntu-ssh:latest
MAINTAINER Gen Takahashi "gendosu@gmail.com"

RUN apt-get update

RUN apt-get install -y git libssl-dev libreadline-dev imagemagick libmagick++-dev libqtwebkit-dev xvfb libffi-dev mysql-client libmysqlclient-dev

RUN git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN mkdir -p /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
RUN /usr/local/rbenv/plugins/ruby-build/install.sh
ENV PATH /usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> .bashrc
RUN echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> .bashrc
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

ENV CONFIGURE_OPTS --disable-install-doc

EXPOSE 22

CMD ["/usr/bin/supervisord"]

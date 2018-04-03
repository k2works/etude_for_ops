FROM jenkins:2.0
USER root
RUN apt-get update && apt-get install -y \
                                      gcc \
                                      make \
                                      g++ \
                                      libssl-dev \
                                      libreadline-dev \
                                      zlib1g-dev \
                                      && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
                                      nodejs \
                                      mysql-client \
                                      libmysqlclient-dev \
                                      postgresql-client \
                                      sqlite3 \
                                      libsqlite3-dev \
                                      && rm -rf /var/lib/apt/lists/*
USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

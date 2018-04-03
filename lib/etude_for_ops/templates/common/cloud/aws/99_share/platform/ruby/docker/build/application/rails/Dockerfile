FROM ruby:2.4.2

RUN apt-get update && apt-get install -y \
                                      vim \
                                      curl && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y \
                                      mysql-client postgresql-client \
                                      sqlite3 --no-install-recommends \
                                      xvfb libqt4-dev libqtwebkit-dev \
                                      nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Make ssh dir
RUN mkdir /root/.ssh/

# Copy over private key, and set permissions
ADD id_rsa /root/.ssh/id_rsa
RUN chmod 0600 /root/.ssh/id_rsa

# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add github key
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
# Add bitbuckets key
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts

# Setup Rails Application
ENV APP_REPOSITORY=git@github.com:k2works/etude_for_rails.git
ENV BRANCH=develop
ADD dummyfile /data/
RUN git clone -b $BRANCH --depth 1 $APP_REPOSITORY .
RUN bundle install

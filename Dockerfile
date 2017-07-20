FROM ruby:2.3.1

# Heroku Toolbelt
RUN wget https://cli-assets.heroku.com/branches/stable/heroku-linux-amd64.tar.gz -O heroku.tar.gz \
    && mkdir -p /usr/local/lib \
    && tar -xvzf heroku.tar.gz -C /usr/local/lib \
    && /usr/local/lib/heroku/install
FROM app:base

RUN wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+trusty_all.deb
RUN dpkg -i zabbix-release_3.0-1+trusty_all.deb
RUN apt-get update && apt-get install -y \
                                       zabbix-agent \
                                       supervisor \
                                       && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/supervisor
COPY ./etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf
RUN rm ./zabbix-release_3.0-1+trusty_all.deb

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY ./config/secrets.yml /usr/src/app/config/secrets.yml
COPY ./config/database.yml /usr/src/app/config/database.yml

RUN curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
RUN echo "deb http://packages.treasuredata.com/2/debian/jessie/ jessie contrib" > /etc/apt/sources.list.d/treasure-data.list
RUN apt-get update
RUN apt-get install -y --force-yes td-agent
COPY ./etc/td-agent/td-agent.conf /etc/td-agent/td-agent.conf
COPY ./etc/td-agent/test.rb /etc/td-agent/test.rb
COPY ./etc/td-agent/Gemfile /etc/td-agent/Gemfile

EXPOSE 3000 10051
CMD ["/usr/bin/supervisord"]
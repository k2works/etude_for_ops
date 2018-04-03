FROM proxy-app:base
COPY nginx.conf /etc/nginx/nginx.conf
COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf

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

RUN curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
RUN echo "deb http://packages.treasuredata.com/2/debian/jessie/ jessie contrib" > /etc/apt/sources.list.d/treasure-data.list
RUN apt-get update
RUN apt-get install -y --force-yes td-agent
COPY ./etc/td-agent/td-agent.conf /etc/td-agent/td-agent.conf

RUN unlink /var/log/nginx/access.log
RUN unlink /var/log/nginx/error.log

CMD ["/usr/bin/supervisord"]
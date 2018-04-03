FROM elasticsearch:2.4.2

RUN echo "network.bind_host: 0.0.0.0" >> /usr/share/elasticsearch/config/elasticsearch.yml
RUN /usr/share/elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf/master
FROM logging-app:base
RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-rdoc", "--no-ri"]
COPY fluent.conf /fluentd/etc/

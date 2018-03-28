FROM anapsix/alpine-java:8_server-jre

ENV JAVA_OPTS="-Xms512m -Xmx512m" \
    CONFD_VERSION="0.15.0" \
    JMX_EXPORTER_VERSION="0.10"

ADD https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 /usr/local/bin/confd
COPY confd /etc/confd
COPY entrypoint.sh /opt/entrypoint.sh

RUN mkdir /opt/jmx_prometheus_httpserver && \
  wget "http://central.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_httpserver/${JMX_EXPORTER_VERSION}/jmx_prometheus_httpserver-${JMX_EXPORTER_VERSION}-jar-with-dependencies.jar" \
    -O /opt/jmx_prometheus_httpserver/jmx_prometheus_httpserver.jar && \
  chmod +x /usr/local/bin/confd && \
  chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]

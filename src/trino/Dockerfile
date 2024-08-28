FROM trinodb/trino:436

USER root
RUN microdnf install -y gzip wget


RUN wget https://github.com/aakashnand/trino-ranger-demo/releases/download/trino-ranger-demo-v1.0/ranger-3.0.0-SNAPSHOT-trino-plugin-436.tar.gz && \
mv ranger-3.0.0-SNAPSHOT-trino-plugin-436.tar.gz /tmp/ranger-3.0.0-SNAPSHOT-trino-plugin.tar.gz
RUN tar -xzf /tmp/ranger-3.0.0-SNAPSHOT-trino-plugin.tar.gz

# elasticsearch compatibility fix
RUN rm -f /ranger-3.0.0-SNAPSHOT-trino-plugin/lib/ranger-trino-plugin-impl/lucene-core-*.jar
RUN wget -qO /ranger-3.0.0-SNAPSHOT-trino-plugin/lib/ranger-trino-plugin-impl/log4j-api-2.11.1.jar https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.11.1/log4j-api-2.11.1.jar
RUN wget -qO /ranger-3.0.0-SNAPSHOT-trino-plugin/lib/ranger-trino-plugin-impl/log4j-core-2.11.1.jar https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.11.1/log4j-core-2.11.1.jar
RUN wget -qO /ranger-3.0.0-SNAPSHOT-trino-plugin/lib/ranger-trino-plugin-impl/lucene-core-8.7.0.jar https://repo1.maven.org/maven2/org/apache/lucene/lucene-core/8.7.0/lucene-core-8.7.0.jar

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
USER trino
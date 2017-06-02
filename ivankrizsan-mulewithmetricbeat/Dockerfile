# Mule ESB CE 3.8.1 with Metricbeat.

FROM ivankrizsan/mule-docker:3.8.1

MAINTAINER Ivan Krizsan, https://github.com/krizsan

# MetricBeat version.
ENV METRICBEAT_VERSION=5.4.0 \
# MetricBeat installation directory.
    METRICBEAT_HOME=/opt/metricbeat

# Install MetricBeat, which is going to monitor the Mule instance.
RUN cd /opt && \
    wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz && \
    tar -xvvf metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz && \
    mv metricbeat-${METRICBEAT_VERSION}-linux-x86_64 metricbeat && \
    mv ${METRICBEAT_HOME}/metricbeat.yml ${METRICBEAT_HOME}/metricbeat.example.yml && \
    mv ${METRICBEAT_HOME}/metricbeat /bin/metricbeat && \
    chmod +x /bin/metricbeat && \
    mkdir -p ${METRICBEAT_HOME}/conf ${METRICBEAT_HOME}/data ${METRICBEAT_HOME}/logs && \
    rm metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz

# Copy the script used to launch Mule ESB and MetricBeat when a container is started.
COPY ./start-mule.sh /opt/
# Copy configuration files to MetricBeat configuration directory.
COPY ./metricbeat-conf/*.* ${METRICBEAT_HOME}/conf/

# Make the start-script executable.
RUN chmod +x /opt/start-mule.sh && \
# Set the owner of all Mule-related files to the user which will be used to run Mule.
    chown -R ${RUN_AS_USER}:${RUN_AS_USER} ${MULE_HOME}

WORKDIR ${MULE_HOME}

# Default when starting the container is to start Mule ESB.
CMD [ "/opt/start-mule.sh" ]

# Define mount points.
VOLUME ["${MULE_HOME}/logs", "${MULE_HOME}/conf", "${MULE_HOME}/apps", "${MULE_HOME}/domains", "${METRICBEAT_HOME}/config", "${METRICBEAT_HOME}/data", "${METRICBEAT_HOME}/logs"]

# Default http port
EXPOSE 8081
# JMX port.
EXPOSE 1099
# Jolokia port.
EXPOSE 8899

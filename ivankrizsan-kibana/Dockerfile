# Kibana Docker image which modifies the startup script as to wait
# for Elasticsearch to be ready before proceeding to start Kibana
# and installs additional plug-in(s).

FROM kibana:4.4.1

COPY ./start-kibana.sh /
RUN apt-get update && \
    apt-get -y install curl && \
    chmod +x /start-kibana.sh && \
    kibana plugin --install elastic/sense && \
# Need to set owner of all the Kibana files since installing the above plugin runs as root
# and thus the installed files will be owned by root which will cause Kibana to fail.
    chown -R kibana:kibana /opt/kibana

EXPOSE 5601
ENTRYPOINT ["/start-kibana.sh"]
CMD ["kibana"]

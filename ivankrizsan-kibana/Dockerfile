# Kibana 4.2 Docker image which modifies the startup script as to wait
# for Elasticsearch to be ready before proceeding to start Kibana
# and installs additional plug-in(s).

FROM kibana:4.2

COPY ./start-kibana.sh /
RUN chmod +x /start-kibana.sh && \
    kibana plugin --install elastic/sense

EXPOSE 5601
ENTRYPOINT ["/start-kibana.sh"]
CMD ["kibana"]

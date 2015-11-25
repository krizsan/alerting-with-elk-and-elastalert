# Elasticsearch 2.0 Docker image which wraps the official image and
# installs additional plug-ins.
#
# Access the Kopf plug-in: http://localhost:9200/_plugin/kopf
# Access the HQ plug-in: http://localhost:9200/_plugin/hq

FROM elasticsearch:2.0

RUN plugin install royrusso/elasticsearch-HQ && \
    plugin install lmenezes/elasticsearch-kopf/2.0

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]

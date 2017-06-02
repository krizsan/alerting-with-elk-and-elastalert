# Alerting with ELK and Elastalert
Configuration for article on alerting with the ELK stack and Elastalert.
The article can be found here:
http://www.ivankrizsan.se/2015/12/06/alerting-with-the-elk-stack-and-elastalert/

There are two branches in this repository. The original branch is the old version of the project from when the first article was written. The master branch contains an updated version using more recent versions of Elasticsearch, Kibana and Elastalert. In addition, Logstash has been replaced with MetricBeat as far as poller and shipper of JMX data.

This configuration has been modified since the article was written as to work in a Linux environment. Also verified in a Mac OS X environment with Docker for Mac. Will need changes if you are to use the old Docker Toolbox for Mac.

In this version of the example, the Elastic.co images of Elasticsearch and Kibana has been used. These include a demo version of X-Pack. To log in to Kibana, use the username "elastic" and the password "changeme". The name of the index to use is "metricbeat-*".

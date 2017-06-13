#! /bin/sh
# Set the timezone. Base image does not contain the setup-timezone script, so an alternate way is used.
if [ "$SET_CONTAINER_TIMEZONE" = "true" ]; then
    cp /usr/share/zoneinfo/${CONTAINER_TIMEZONE} /etc/localtime && \
	echo "${CONTAINER_TIMEZONE}" >  /etc/timezone && \
	echo "Container timezone set to: $CONTAINER_TIMEZONE"
else
	echo "Container timezone not modified"
fi

# Force immediate synchronisation of the time and start the time-synchronization service.
# In order to be able to use ntpd in the container, it must be run with the SYS_TIME capability.
# In addition you may want to add the SYS_NICE capability, in order for ntpd to be able to modify its priority.
ntpd -s

# Set RMI server IP address in the Mule ESB wrapper configuration as to make JMX reachable from outside the container.
if [ -z "$MULE_EXTERNAL_IP" ]
then
    echo "No external Mule ESB IP address set, using 192.168.99.100."
    MULE_EXTERNAL_IP="192.168.99.100"
else
    echo "Mule ESB external IP address set to $MULE_EXTERNAL_IP"
fi
sed -i -e"s|Djava.rmi.server.hostname=.*|Djava.rmi.server.hostname=${MULE_EXTERNAL_IP}|g" ${MULE_HOME}/conf/wrapper.conf

# Start MetricBeat in the background.
(cd ${METRICBEAT_HOME} && exec metricbeat -v -c ${METRICBEAT_HOME}/conf/metricbeat.yml) &

# Start Mule ESB.
# The Mule startup script will take care of launching Mule using the appropriate user.
# Mule is launched in the foreground and will thus be the main process of the container.
${MULE_HOME}/bin/mule console

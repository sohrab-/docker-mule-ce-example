#!/bin/bash

# compile the templated properties file, if not already
PROPERTIES_FILE=/opt/mule/conf/sample-app.properties
if [ ! -f $PROPERTIES_FILE ] ; then
	echo "Replacing $PROPERTIES_FILE"
	erb /build/sample-app.properties.erb > $PROPERTIES_FILE
	chown mule $PROPERTIES_FILE
fi

echo "Starting Mule CE Server"
exec mule
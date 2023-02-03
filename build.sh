#!/usr/bin/env bash

# uncomment these 2 lines below when image needs to build using latest routing data for are

# wget http://download.geofabrik.de/europe/sweden-latest.osm.pbf
# mv sweden-latest.osm.pbf ./openrouteservice/src/main/files/ 

# create directories for volumes to mount as local user
mkdir -p conf elevation_cache graphs logs/ors logs/tomcat

# build image
docker build --no-cache -t ors-api:latest . 

# run image
docker run -dt -u "${UID}:${GID}" --name ors-app -p 8080:8080 -v $PWD/graphs:/ors-core/data/graphs -v $PWD/elevation_cache:/ors-core/data/elevation_cache -v $PWD/conf:/ors-conf -v $PWD/openrouteservice:/ors-core/openrouteservice -v $PWD/openrouteservice/src/main/files/sweden-latest.osm.pbf:/ors-core/data/osm_file.pbf -e BUILD_GRAPHS="True"  -e "JAVA_OPTS=-Djava.awt.headless=true -server -XX:TargetSurvivorRatio=75 -XX:SurvivorRatio=64 -XX:MaxTenuringThreshold=3 -XX:+UseG1GC -XX:+ScavengeBeforeFullGC -XX:ParallelGCThreads=4 -Xms3g -Xmx6g" -e "CATALINA_OPTS=-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9001 -Dcom.sun.management.jmxremote.rmi.port=9001 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=localhost"  openrouteservice/openrouteservice:latest
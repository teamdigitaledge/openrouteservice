#uncomment these 2 lines below when image needs to build using latest routing data for are

# wget http://download.geofabrik.de/europe/sweden-latest.osm.pbf
# mv sweden-latest.osm.pbf ./openrouteservice/src/main/files/


cd dockers
docker-compose build
mkdir -p conf elevation_cache graphs logs/ors logs/tomcat && docker-compose up
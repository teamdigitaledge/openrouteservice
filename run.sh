
docker build --no-cache -t ors-api:latest .      
cd docker                       
docker compose build
mkdir -p conf elevation_cache graphs logs/ors logs/tomcat && docker-compose up
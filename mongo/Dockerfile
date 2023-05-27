FROM mongo:latest

ENV MONGO_INITDB_ROOT_USERNAME=rootusername \
    MONGO_INITDB_ROOT_PASSWORD=astrongpassword \
    MONGO_INITDB_DATABASE=databasename

# Copy Configuration file:
COPY ./mongod.conf /etc/mongod.conf

# Copy Initialization .js files:
COPY init/* /docker-entrypoint-initdb.d/

# Expose to the World:
EXPOSE 27017

# Ensure Persistence of Data:
VOLUME ["/data/db/", "/data/configdb/", "/var/log/mongodb/"]

FROM postgres:latest

ENV POSTGRES_USER=defaultusername \
    POSTGRES_PASSWORD=astrongpassword \
    POSTGRES_DB=data

# Copy Initialization .sql files:
COPY init/* /docker-entrypoint-initdb.d/

# Expose to the World:
EXPOSE 5432

# Ensure Persistence of Data:
VOLUME ["/var/lib/postgresql/data"]

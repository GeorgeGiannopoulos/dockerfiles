FROM ubuntu:20.04

ENV OPENFIRE_VERSION=4.7.5 \
    OPENFIRE_USER=openfire \
    OPENFIRE_DATA_DIR=/var/lib/openfire \
    OPENFIRE_LOG_DIR=/var/log/openfire

# Install dependencies:
ADD ./build/system_services.sh /build/system_services.sh
RUN chmod 750 /build/system_services.sh
RUN /build/system_services.sh

# Install Java:
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -q --no-install-recommends openjdk-8-jdk \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

# Install openFire:
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -q --no-install-recommends wget \
    && wget "https://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_${OPENFIRE_VERSION}_all.deb" -O /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
    && dpkg -i /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
    && mv /var/lib/openfire/plugins/admin /usr/share/openfire/plugin-admin \
    && rm -rf openfire_${OPENFIRE_VERSION}_all.deb \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

# Copy auto-setup configuration:
# NOTE: following configuration file prepares the server. However does not add the rooms
COPY ./build/openfire.xml /etc/openfire/

# Execution script:
COPY ./build/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

# Expose to the World:
EXPOSE 3478 3479 5222 5223 5229 7070 7443 7777 9090 9091

# Ensure Persistence of Data:
VOLUME ["${OPENFIRE_DATA_DIR}"]

# Run the application:
ENTRYPOINT ["/sbin/entrypoint.sh"]

FROM rabbitmq:3.13-management

# Disable unused plugins for minimal attack surface
RUN rabbitmq-plugins disable rabbitmq_delayed_message_exchange \
   rabbitmq_federation \
   rabbitmq_mqtt \
   rabbitmq_stomp \
   rabbitmq_tcp \
   rabbitmq_utils

# Copy configuration scripts:
COPY ./build/* /build/
RUN chmod 750 -R /build/

# Expose to the World:
EXPOSE 4369 5671 5672 15691 15692 25672

# Ensure Persistence of Data:
VOLUME ["/var/lib/rabbitmq", "/etc/rabbitmq/conf.d/", "/etc/rabbitmq/ssl/"]

# Run the application:
ENTRYPOINT ["/build/entrypoint.sh"]
CMD ["rabbitmq-server"]

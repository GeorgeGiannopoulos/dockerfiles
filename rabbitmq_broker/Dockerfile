FROM rabbitmq:3.12-management

# Disable unused plugins for minimal attack surface
RUN rabbitmq-plugins disable rabbitmq_delayed_message_exchange \
   rabbitmq_federation \
   rabbitmq_management_prometheus \
   rabbitmq_mqtt \
   rabbitmq_stomp \
   rabbitmq_tcp \
   rabbitmq_utils

# Expose to the World:
EXPOSE 4369 5671 5672 15691 15692 25672

# Ensure Persistence of Data:
VOLUME ["/var/lib/rabbitmq", "/etc/rabbitmq/conf.d/"]

# Run the application:
CMD ["rabbitmq-server"]

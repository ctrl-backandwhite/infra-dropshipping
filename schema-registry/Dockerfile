# =====================================================================================
# Confluent Schema Registry para Railway, conectado al broker Kafka KRaft por SASL/SCRAM.
#
# Solo red privada (NO le pongas dominio público salvo que quieras exponer la API REST).
# Config no secreta horneada; el JAAS con el password va como variable del servicio.
#
# NOTA: el backend mic-dropshipping serializa en JSON (no Avro), así que NO usa este
# registry. Se incluye para uso futuro / otros microservicios.
# =====================================================================================
FROM confluentinc/cp-schema-registry:7.7.1

ENV SCHEMA_REGISTRY_HOST_NAME=schema-registry \
    SCHEMA_REGISTRY_LISTENERS=http://[::]:8081 \
    SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS=SASL_PLAINTEXT://kafka.railway.internal:9092 \
    SCHEMA_REGISTRY_KAFKASTORE_SECURITY_PROTOCOL=SASL_PLAINTEXT \
    SCHEMA_REGISTRY_KAFKASTORE_SASL_MECHANISM=SCRAM-SHA-256 \
    SCHEMA_REGISTRY_SCHEMA_COMPATIBILITY_LEVEL=backward

# SECRETO → variable del servicio en Railway (ver README):
#   SCHEMA_REGISTRY_KAFKASTORE_SASL_JAAS_CONFIG=org.apache.kafka.common.security.scram.ScramLoginModule required username="nexadrop" password="<KAFKA_SASL_PASSWORD>";

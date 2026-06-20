# =====================================================================================
# Apache Kafka en modo KRaft (sin Zookeeper) para Railway — broker + controller en un nodo.
#
# Seguridad: SASL/SCRAM-SHA-256 OBLIGATORIO en el listener de cliente y de controller.
# Solo red privada de Railway (NO le añadas dominio público).
#
# La config NO secreta va horneada como ENV aquí (versionable). Los PASSWORDS se inyectan
# como variables del servicio en Railway (ver infra/railway/README.md), nunca en la imagen.
#
# El advertised listener se resuelve en runtime con RAILWAY_PRIVATE_DOMAIN (ver entrypoint.sh)
# para que otros servicios alcancen el broker por <servicio>.railway.internal:9092.
# =====================================================================================
FROM bitnami/kafka:3.9

ENV KAFKA_CFG_NODE_ID=1 \
    KAFKA_CFG_PROCESS_ROLES=broker,controller \
    KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=1@localhost:9093 \
    KAFKA_CFG_LISTENERS=CLIENT://[::]:9092,CONTROLLER://[::]:9093 \
    KAFKA_CFG_CONTROLLER_LISTENER_NAMES=CONTROLLER \
    KAFKA_CFG_INTER_BROKER_LISTENER_NAME=CLIENT \
    KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:SASL_PLAINTEXT,CLIENT:SASL_PLAINTEXT \
    KAFKA_CFG_SASL_ENABLED_MECHANISMS=SCRAM-SHA-256 \
    KAFKA_CFG_SASL_MECHANISM_INTER_BROKER_PROTOCOL=SCRAM-SHA-256 \
    KAFKA_CFG_SASL_MECHANISM_CONTROLLER_PROTOCOL=SCRAM-SHA-256 \
    KAFKA_INTER_BROKER_USER=nexadrop \
    KAFKA_CLIENT_USERS=nexadrop \
    KAFKA_CONTROLLER_USER=controller_user

# Passwords (KAFKA_CLIENT_PASSWORDS, KAFKA_INTER_BROKER_PASSWORD, KAFKA_CONTROLLER_PASSWORD)
# se definen como VARIABLES del servicio en Railway — ver README.

COPY entrypoint.sh /railway/entrypoint.sh
USER root
RUN chmod +x /railway/entrypoint.sh
USER 1001
ENTRYPOINT ["/railway/entrypoint.sh"]

#!/bin/bash
set -e

# Railway inyecta RAILWAY_PRIVATE_DOMAIN = "<servicio>.railway.internal".
# El advertised listener de cliente DEBE ser ese hostname para que el backend (y el
# schema-registry) alcancen el broker por la red privada. Se resuelve en runtime para
# no depender del nombre exacto del servicio.
if [ -n "${RAILWAY_PRIVATE_DOMAIN}" ]; then
  export KAFKA_CFG_ADVERTISED_LISTENERS="CLIENT://${RAILWAY_PRIVATE_DOMAIN}:9092"
else
  export KAFKA_CFG_ADVERTISED_LISTENERS="CLIENT://localhost:9092"
fi

echo "[railway] KAFKA_CFG_ADVERTISED_LISTENERS=${KAFKA_CFG_ADVERTISED_LISTENERS}"

# Delegamos en el arranque normal de Bitnami (inicializa KRaft, crea los usuarios SCRAM, etc.).
exec /opt/bitnami/scripts/kafka/entrypoint.sh /opt/bitnami/scripts/kafka/run.sh

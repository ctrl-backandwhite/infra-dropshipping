# infra-dropshipping

Infraestructura desplegable en Railway para la plataforma NX036 Dropshipping.

- `kafka/` — Apache Kafka en modo **KRaft** (sin Zookeeper), seguro con SASL/SCRAM-256.
- `schema-registry/` — Confluent Schema Registry conectado a Kafka por SASL.

Ver el detalle de despliegue, variables y volúmenes en cada subdirectorio / el README de railway.
Los **passwords** se inyectan como variables de servicio en Railway (no están en el repo).

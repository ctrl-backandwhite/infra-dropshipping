# =====================================================================================
# OpenSearch 2.x single-node para Railway, con el plugin de SEGURIDAD ACTIVO (auth + TLS).
#
# IMPORTANTE en Railway:
#   - Service → Settings → Root Directory = "opensearch"  (para que encuentre este Dockerfile)
#   - Builder = Dockerfile (no Railpack/Nixpacks)
#   - Solo red privada (NO le pongas dominio público).
#
# Los settings con punto (discovery.type, etc.) y el password van como VARIABLES del servicio
# (Railway sí acepta nombres con punto; OpenSearch los lee como settings en runtime). NO se
# hornean como ENV con punto aquí porque eso puede romper el build de Docker.
# =====================================================================================
FROM opensearchproject/opensearch:2.19.0

ENV OPENSEARCH_JAVA_OPTS="-Xms512m -Xmx512m"

EXPOSE 9200 9600

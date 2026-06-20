# =====================================================================================
# OpenSearch 2.x single-node para Railway, con el plugin de SEGURIDAD ACTIVO (auth + TLS).
#
# - Solo red privada (NO le pongas dominio público).
# - El password admin se inyecta como VARIABLE del servicio (OPENSEARCH_INITIAL_ADMIN_PASSWORD),
#   nunca en la imagen.
# - single-node ⇒ se omiten los bootstrap checks (incl. vm.max_map_count, que en Railway no
#   se puede subir). Por eso NO hace falta tocar el host.
# =====================================================================================
FROM opensearchproject/opensearch:2.19.0

# Config NO secreta horneada. (OpenSearch lee las claves con punto del entorno como settings.)
ENV discovery.type=single-node \
    bootstrap.memory_lock=false \
    OPENSEARCH_JAVA_OPTS="-Xms512m -Xmx512m"

# Variable de servicio en Railway (secreto): la clave del usuario admin (≥8, mayús, minús, dígito, símbolo).
#   OPENSEARCH_INITIAL_ADMIN_PASSWORD=<clave fuerte>
#
# El backend se conecta por https + auth básica (admin / esa clave). Como el cert es autofirmado
# (demo config) en red privada, el backend usa OPENSEARCH_TLS_INSECURE=true (TLS cifrado pero sin
# validar el cert). Para validación estricta habría que importar la CA del cluster.

EXPOSE 9200 9600

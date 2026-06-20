# infra-dropshipping

Infraestructura desplegable en Railway para la plataforma NX036 Dropshipping.

> Kafka se despliega con la plantilla **"Kafka + Kafka UI (KRaft)"** de Railway (`cp-kafka`),
> así que aquí solo queda **OpenSearch** propio (determinista, bajo nuestro control).

## `opensearch/` — OpenSearch 2.x single-node (seguro)

OpenSearch con el **plugin de seguridad activo** (auth básica + TLS), en **red privada** (sin dominio público).

### Desplegar en Railway
1. **New Service → Deploy from Repo** → selecciona este repo y pon **Root Directory** = `opensearch`.
2. En **Settings → Build**, asegúrate de que el **Builder = Dockerfile** (no Railpack/Nixpacks).
3. **Variable del servicio** (secreto):

   | Variable | Valor |
   |---|---|
   | `OPENSEARCH_INITIAL_ADMIN_PASSWORD` | una clave fuerte (≥8, mayús, minús, dígito y símbolo) |

4. **Volumen** (persistencia de índices): monta un volume en `/usr/share/opensearch/data`.
5. **NO** le añadas dominio público.

### Conexión desde el backend (mic-dropshipping)
Ya configurado por variables:
```
OPENSEARCH_URIS=https://<servicio-opensearch>.railway.internal:9200
OPENSEARCH_USERNAME=admin
OPENSEARCH_PASSWORD=<la misma de OPENSEARCH_INITIAL_ADMIN_PASSWORD>
OPENSEARCH_TLS_INSECURE=true   # cert autofirmado en red privada (cifrado, sin validar CA)
```

### Notas de seguridad
- `single-node` omite los bootstrap checks (incl. `vm.max_map_count`, no ajustable en Railway).
- Auth + TLS activos. El backend confía en el cert autofirmado (`OPENSEARCH_TLS_INSECURE=true`)
  porque va por red privada; para validación estricta, importar la CA del cluster.
- Sin dominio público ⇒ solo accesible desde servicios del mismo proyecto Railway.

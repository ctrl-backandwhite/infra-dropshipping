# infra-dropshipping

Infraestructura desplegable en Railway para la plataforma NX036 Dropshipping.

> Kafka se despliega con la plantilla **"Kafka + Kafka UI (KRaft)"** de Railway (`cp-kafka`),
> así que aquí solo queda **OpenSearch** propio (determinista, bajo nuestro control).

## `opensearch/` — OpenSearch 2.x single-node (seguro)

OpenSearch con el **plugin de seguridad activo** (auth básica + TLS), en **red privada** (sin dominio público).

### Desplegar en Railway (IMPORTANTE el Root Directory)
1. **New Service → Deploy from Repo** → este repo.
2. **Settings → Source → Root Directory** = **`opensearch`** ← imprescindible (si no, Railway construye
   desde la raíz, no encuentra el Dockerfile y falla el build).
3. **Settings → Build → Builder** = **Dockerfile** (no Railpack/Nixpacks).
4. **Variables del servicio** (Settings → Variables):

   | Variable | Valor |
   |---|---|
   | `OPENSEARCH_INITIAL_ADMIN_PASSWORD` | clave fuerte (≥8, mayús, minús, dígito, símbolo) |
   | `discovery.type` | `single-node` |
   | `bootstrap.memory_lock` | `false` |

   *(Railway acepta nombres de variable con punto; OpenSearch los lee como settings.)*
5. **Volumen** (persistencia de índices): monta un volume en `/usr/share/opensearch/data`.
6. **NO** le añadas dominio público.

### Conexión desde el backend (mic-dropshipping) — ya configurado por variables
```
OPENSEARCH_URIS=https://<servicio-opensearch>.railway.internal:9200
OPENSEARCH_USERNAME=admin
OPENSEARCH_PASSWORD=<la misma de OPENSEARCH_INITIAL_ADMIN_PASSWORD>
OPENSEARCH_TLS_INSECURE=true   # cert autofirmado en red privada (cifrado, sin validar CA)
```

### Notas de seguridad
- `single-node` omite los bootstrap checks (incl. `vm.max_map_count`, no ajustable en Railway).
- Auth + TLS activos. El backend confía en el cert autofirmado (`OPENSEARCH_TLS_INSECURE=true`)
  por ir en red privada; para validación estricta, importar la CA del cluster.
- Sin dominio público ⇒ solo accesible desde servicios del mismo proyecto Railway.

## `minio/` — MinIO object storage (imágenes de producto)

Imagen **oficial** `minio/minio`, propia y determinista (NO el template Bitnami, retirado de Docker Hub en 2025).

### Desplegar en Railway (IMPORTANTE el Root Directory)
1. **New Service → Deploy from Repo** → este repo.
2. **Settings → Source → Root Directory** = **`minio`** ← imprescindible.
3. **Settings → Build → Builder** = **Dockerfile**.
4. **Volumen** (persistencia): monta un volume en **`/data`** (mismo mount que el template anterior).
5. **Networking**: genera **DOMINIO PÚBLICO en el puerto `9000`** (API S3). *(No expongas 9001/consola.)*
6. **Variables del servicio**:

   | Variable | Valor |
   |---|---|
   | `MINIO_ROOT_USER` | `nexadrop` |
   | `MINIO_ROOT_PASSWORD` | `<misma que STORAGE_SECRET_KEY del backend>` |

El **bucket `product-images`** y su política de lectura pública los crea el backend al arrancar.

### Conexión desde el backend (mic-dropshipping)
- `STORAGE_ENDPOINT=http://minio.railway.internal:9000`
- `STORAGE_PUBLIC_URL=https://<dominio-público-minio>/product-images`
- `STORAGE_BUCKET=product-images`
- `STORAGE_ACCESS_KEY=nexadrop`
- `STORAGE_SECRET_KEY=<misma password que MINIO_ROOT_PASSWORD>`

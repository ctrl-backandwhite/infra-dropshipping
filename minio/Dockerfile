# =====================================================================================
# MinIO (S3-compatible) — imagen OFICIAL de MinIO, propia y bajo nuestro control (NO el
# template Bitnami de la comunidad, que Docker Hub retiró en 2025 y dejó de desplegar).
#
# Almacén de imágenes de producto: el backend (mic-dropshipping) descarga las imágenes de
# origen (1688/Taobao) SIN Referer y las sube aquí; el navegador las sirve desde el DOMINIO
# PÚBLICO de este servicio (puerto 9000 = API S3). El bucket `product-images` y su política
# de lectura pública los crea el backend al arrancar.
#
# IMPORTANTE en Railway:
#   - Service → Settings → Config-as-code Path = "minio/railway.toml"
#   - Volumen (persistencia) montado en /data. Los DATOS viven en /data/minio (subdir usado
#     por el despliegue anterior) → el drive de MinIO apunta ahí para NO perder las imágenes.
#   - Dominio público en el puerto 9000 (API S3). No expongas 9001/consola.
#   - Variables del servicio: MINIO_ROOT_USER, MINIO_ROOT_PASSWORD (secretos).
#
# Nota: la red privada/healthcheck de Railway es IPv6 → bindeamos en `[::]` (dual-stack).
# =====================================================================================
FROM minio/minio:latest

EXPOSE 9000 9001

# Drive en /data/minio (donde están los datos existentes). API S3 en 9000, consola en 9001.
CMD ["server", "/data/minio", "--address", "[::]:9000", "--console-address", "[::]:9001"]

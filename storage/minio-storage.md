- `${MINIO_DOMAIN}` = `'storage.***REMOVED***.ru'`
- `${MINIO_ACCESS_KEY}` = `'***REMOVED***'`
- `${MINIO_SECRET_KEY}` = `'12345'`

```yaml
version: "3.6"
services:

  minio:
    image: minio/minio
    environment:
      MINIO_DOMAIN: ${MINIO_DOMAIN}
      MINIO_ACCESS_KEY: ${MINIO_ACCESS_KEY}
      MINIO_SECRET_KEY: ${MINIO_SECRET_KEY}
    ports:
      - "9000:9000"
    volumes:
      - /data:/data
    command: server /data
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:9000/minio/health/live"]
      interval: 20s
      timeout: 20s
      retries: 3
    networks:
      - ***REMOVED***

networks:
  ***REMOVED***-network:
    external: true

```


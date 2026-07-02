FROM minio/minio:latest
ENTRYPOINT []
CMD ["/bin/sh","-c","echo '===TREE==='; find /data -maxdepth 4 2>/dev/null | grep -viE '/\\.minio\\.sys/' | head -80; echo '===DU==='; du -sh /data/* 2>/dev/null | head -20; echo '===END==='; sleep 900"]

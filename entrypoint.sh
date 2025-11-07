#!/bin/bash

# Config from your compose
DATA_DIR="/data"
STORAGE_FILE="${DATA_DIR}/0_0.tigerbeetle"
CLUSTER=0
REPLICA=0
REPLICA_COUNT=1
BIND_PORT=3000  # Optional: Add --bind=0.0.0.0:${BIND_PORT} if needed for external binding

# Ensure data dir exists
mkdir -p "${DATA_DIR}"

# Format only if storage file doesn't exist (one-time init)
if [ ! -f "${STORAGE_FILE}" ]; then
  echo "Formatting TigerBeetle storage (first run)..."
  tigerbeetle format \
    --cluster=${CLUSTER} \
    --replica=${REPLICA} \
    --replica-count=${REPLICA_COUNT} \
    "${STORAGE_FILE}"
  echo "Formatting complete."
else
  echo "Storage file exists; skipping format."
fi

# Start the server (your compose command; add --bind if single-replica external access needed)
echo "Starting TigerBeetle server..."
exec tigerbeetle start \
  --addresses=0.0.0.0:${BIND_PORT} \
  "${STORAGE_FILE}"

# If you need --bind for single-replica: Uncomment below and comment the exec line above
# exec tigerbeetle start \
#   --bind=0.0.0.0:${BIND_PORT} \
#   --addresses=0.0.0.0:${BIND_PORT} \
#   "${STORAGE_FILE}"

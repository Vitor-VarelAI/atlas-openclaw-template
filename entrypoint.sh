#!/bin/bash
set -e

# Copy default config if not exists in volume
if [ ! -f "/data/.openclaw/openclaw.json" ]; then
    echo "[init] Copying default openclaw.json to volume..."
    mkdir -p /data/.openclaw
    cp /app/defaults/openclaw.json /data/.openclaw/openclaw.json
fi

# Copy skills if directory is empty
if [ ! -d "/data/workspace/skills" ] || [ -z "$(ls -A /data/workspace/skills 2>/dev/null)" ]; then
    echo "[init] Copying default skills to volume..."
    mkdir -p /data/workspace
    cp -r /app/defaults/skills /data/workspace/
fi

echo "[init] Config ready at /data/.openclaw/openclaw.json"

# Start the wrapper
exec node src/server.js

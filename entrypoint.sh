#!/bin/bash
set -e

echo "[init] OpenClaw wrapper starting..."
echo "[init] Use /setup to configure the bot"

# Start the wrapper
exec node src/server.js


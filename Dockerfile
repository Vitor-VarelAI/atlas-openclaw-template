# Use official OpenClaw image
FROM ghcr.io/openclaw/openclaw:latest

# Switch to root to create directories
USER root

# Create directories with correct permissions
RUN mkdir -p /data/.openclaw /data/workspace && \
    chown -R node:node /data

# Switch back to node user
USER node

# Copy our custom configuration
COPY --chown=node:node openclaw.json /data/.openclaw/openclaw.json
COPY --chown=node:node skills/ /data/workspace/skills/

# Set environment variables
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace
ENV OPENCLAW_CONFIG_PATH=/data/.openclaw/openclaw.json

# Expose port
EXPOSE 8080

# Start the gateway
CMD ["openclaw", "gateway", "--port", "8080"]

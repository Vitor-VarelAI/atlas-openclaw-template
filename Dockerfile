# Use official OpenClaw image
FROM ghcr.io/openclaw/openclaw:latest

# Create directories
RUN mkdir -p /data/.openclaw /data/workspace

# Copy our custom configuration
COPY openclaw.json /data/.openclaw/openclaw.json
COPY skills/ /data/workspace/skills/

# Set environment variables
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace
ENV OPENCLAW_CONFIG_PATH=/data/.openclaw/openclaw.json

# Expose port
EXPOSE 8080

# Start the gateway
CMD ["openclaw", "gateway", "--port", "8080"]

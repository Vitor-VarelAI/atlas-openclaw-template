# Use official OpenClaw image
FROM ghcr.io/openclaw/openclaw:latest

# Copy our custom configuration
COPY openclaw.json /app/openclaw.json
COPY skills/ /app/skills/

# Set working directory
WORKDIR /app

# Expose port
EXPOSE 8080

# The base image already has the entrypoint configured

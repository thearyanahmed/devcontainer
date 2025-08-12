# Use the official Node.js 20 image as base
FROM mcr.microsoft.com/devcontainers/javascript-node:20-bullseye

# Install additional tools for Next.js development
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        git \
        curl \
        wget \
        unzip \
        ca-certificates \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Set up npm configuration for better performance
RUN npm config set fund false \
    && npm config set audit false

# Create workspace directory
WORKDIR /workspaces

# Set proper ownership for the node user
RUN chown -R node:node /workspaces

# Switch to node user
USER node

# Set environment variables
ENV NODE_ENV=development
ENV NEXT_TELEMETRY_DISABLED=1

# Expose the Next.js development server port
EXPOSE 3000
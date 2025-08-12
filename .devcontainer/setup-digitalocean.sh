#!/bin/bash
set -e

echo "🚀 Setting up DigitalOcean tools and MCP server..."

# Install doctl (DigitalOcean CLI)
echo "📦 Installing doctl..."
cd /tmp
curl -sL https://github.com/digitalocean/doctl/releases/download/v1.110.0/doctl-1.110.0-linux-amd64.tar.gz | tar -xzv
sudo mv doctl /usr/local/bin
echo "✅ doctl installed successfully"

# Verify doctl installation
doctl version

# Set up DigitalOcean MCP server
echo "🔧 Setting up DigitalOcean MCP server..."

# Determine the current workspace directory
WORKSPACE_DIR=$(pwd)
echo "Current workspace: $WORKSPACE_DIR"

# Install the DigitalOcean MCP package globally
echo "📦 Installing DigitalOcean MCP package..."
npm install -g @digitalocean/mcp

# Test the installation
echo "🧪 Testing MCP installation..."
npx @digitalocean/mcp --help

echo "✅ DigitalOcean MCP server installed successfully!"
echo "   You can now use: npx @digitalocean/mcp --services <service_names>"

echo "✅ DigitalOcean MCP server setup complete!"

# Initialize doctl if token is available
if [ -n "$DIGITALOCEAN_ACCESS_TOKEN" ] || [ -n "$DO_TOKEN" ] || [ -n "$DOCTL_ACCESS_TOKEN" ]; then
    echo "🔑 Initializing doctl with access token..."
    
    # Use whichever token is available
    TOKEN=${DIGITALOCEAN_ACCESS_TOKEN:-${DO_TOKEN:-${DOCTL_ACCESS_TOKEN}}}
    
    if [ -n "$TOKEN" ]; then
        doctl auth init --access-token "$TOKEN"
        echo "✅ doctl authenticated successfully"
        
        # Test the connection
        echo "🧪 Testing DigitalOcean API connection..."
        doctl account get
    else
        echo "⚠️  No DigitalOcean access token found in environment variables"
        echo "   Set DIGITALOCEAN_ACCESS_TOKEN, DO_TOKEN, or DOCTL_ACCESS_TOKEN in your host environment"
    fi
else
    echo "⚠️  No DigitalOcean access token found"
    echo "   To authenticate doctl, set one of these environment variables on your host:"
    echo "   - DIGITALOCEAN_ACCESS_TOKEN"
    echo "   - DO_TOKEN"
    echo "   - DOCTL_ACCESS_TOKEN"
fi

echo ""
echo "🎉 Setup complete! You can now use:"
echo "   - doctl: DigitalOcean CLI tool"
echo "   - MCP server: @digitalocean/mcp npm package"
echo ""
echo "💡 Next steps:"
echo "   1. Set your DigitalOcean token in host environment if not done already"
echo "   2. Use 'doctl' commands to manage your DigitalOcean resources"
echo "   3. Use MCP server with: npx @digitalocean/mcp --services apps,droplets"
echo "   4. Configure Claude Desktop to use the MCP server"
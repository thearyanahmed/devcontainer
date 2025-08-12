# DevContainer Setup for Next.js Documentation Site

This repository includes a complete DevContainer configuration for streamlined development using Visual Studio Code and Docker. The setup provides a consistent, isolated development environment with all necessary tools pre-configured.

## 🚀 Quick Start

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop) installed and running
- [Visual Studio Code](https://code.visualstudio.com/) with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- **DigitalOcean Personal Access Token** (optional, for DigitalOcean integration)

### Environment Setup (Optional - For DigitalOcean Integration)
Before opening the container, set up your DigitalOcean access token:

1. **Get your DigitalOcean token**:
   - Go to [DigitalOcean API Tokens](https://cloud.digitalocean.com/account/api/tokens)
   - Generate a new Personal Access Token with read/write permissions

2. **Set environment variable** on your host machine:
   ```bash
   # Option 1: Set in your shell profile (~/.zshrc, ~/.bashrc, etc.)
   export DIGITALOCEAN_ACCESS_TOKEN="your_token_here"
   
   # Option 2: Alternative variable names (any will work)
   export DO_TOKEN="your_token_here"
   # or
   export DOCTL_ACCESS_TOKEN="your_token_here"
   ```

3. **Restart VS Code** to pick up the new environment variable

### Getting Started
1. **Open the project in VS Code**
2. **Reopen in Container**: When prompted, click "Reopen in Container" or use `Ctrl+Shift+P` → "Dev Containers: Reopen in Container"
3. **Wait for setup**: The container will build and install dependencies automatically
   - This includes installing doctl and setting up the DigitalOcean MCP server
4. **Start developing**: Run `npm run dev` to start the development server

## 📁 DevContainer Configuration

### File Structure
```
.devcontainer/
├── devcontainer.json       # Main configuration file
├── Dockerfile             # Custom development image
└── setup-digitalocean.sh  # DigitalOcean tools setup script
```

### DigitalOcean MCP Server Integration
The DevContainer automatically installs the [DigitalOcean MCP server](https://github.com/digitalocean-labs/mcp-digitalocean) which allows Claude Desktop to interact with your DigitalOcean resources.

**Installation**: `@digitalocean/mcp` npm package (globally installed)

**Usage**: 
```bash
# Enable specific services (recommended)
npx @digitalocean/mcp --services apps,droplets

# Enable all services
npx @digitalocean/mcp --services apps,droplets,databases,kubernetes,load-balancers
```

**To use with Claude Desktop**:
1. Add to your Claude Desktop configuration (`~/Library/Application Support/Claude/claude_desktop_config.json` on macOS):
   ```json
   {
     "mcpServers": {
       "digitalocean": {
         "command": "npx",
         "args": ["@digitalocean/mcp", "--services", "apps,droplets"],
         "env": {
           "DIGITALOCEAN_ACCESS_TOKEN": "your_token_here"
         }
       }
     }
   }
   ```
2. Restart Claude Desktop to enable the MCP server

### Key Features
- **Node.js 20 LTS** with TypeScript support
- **Pre-configured VS Code extensions** for Next.js development
- **Port forwarding** for Next.js dev server (port 3000)
- **Automatic dependency installation** on container creation
- **Zsh with Oh My Zsh** for enhanced terminal experience
- **GitHub CLI** pre-installed
- **DigitalOcean CLI (doctl)** pre-installed
- **DigitalOcean MCP server** for Claude Desktop integration
- **Python 3** with pip for MCP server support

## 🛠 Development Commands

### Essential Commands
```bash
# Start development server
npm run dev

# Build for production
npm run build

# Run production server
npm start

# Run linter
npm run lint

# Install new dependencies
npm install <package-name>
```

### DigitalOcean Commands
```bash
# Check doctl version
doctl version

# List your DigitalOcean droplets
doctl compute droplet list

# Get account information
doctl account get

# List all available doctl commands
doctl --help

# Authenticate doctl (if not done automatically)
doctl auth init --access-token YOUR_TOKEN
```

### Development Server
- **URL**: http://localhost:3000
- **Port**: 3000 (automatically forwarded)
- **Auto-reload**: Enabled for file changes

## ⚙️ Configuration Details

### VS Code Extensions Included
- **Tailwind CSS IntelliSense** - Autocomplete and syntax highlighting
- **Prettier** - Code formatting
- **ESLint** - Code linting
- **TypeScript** - Enhanced TypeScript support
- **MDX** - Syntax highlighting for MDX files
- **Path Intellisense** - Autocomplete for file paths
- **Auto Rename Tag** - Automatically rename paired HTML/JSX tags
- **NPM Scripts** - Run npm scripts from VS Code

### Container Specifications
- **Base Image**: `mcr.microsoft.com/devcontainers/javascript-node:20-bullseye`
- **User**: `node` (non-root for security)
- **Working Directory**: `/workspaces/protocol-ts`
- **Environment**: Development mode with telemetry disabled

### Port Configuration
| Port | Service | Description |
|------|---------|-------------|
| 3000 | Next.js Dev Server | Main development server |

## 🔧 Customization

### Adding VS Code Extensions
Edit `.devcontainer/devcontainer.json`:
```json
{
  "customizations": {
    "vscode": {
      "extensions": [
        "existing.extensions",
        "your.new.extension"
      ]
    }
  }
}
```

### Adding System Packages
Edit `.devcontainer/Dockerfile`:
```dockerfile
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        your-package-name \
    && apt-get autoremove -y
```

### Environment Variables
Add to `.devcontainer/devcontainer.json`:
```json
{
  "containerEnv": {
    "YOUR_ENV_VAR": "value"
  }
}
```

### Additional Features
Add to `.devcontainer/devcontainer.json`:
```json
{
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:2": {},
    "ghcr.io/devcontainers/features/aws-cli:1": {}
  }
}
```

## 🐛 Troubleshooting

### Container Won't Start
1. **Check Docker is running**: Ensure Docker Desktop is running
2. **Clear Docker cache**: Run `docker system prune -a` (⚠️ removes all Docker data)
3. **Rebuild container**: `Ctrl+Shift+P` → "Dev Containers: Rebuild Container"

### Port Already in Use
1. **Check running processes**: `lsof -i :3000`
2. **Kill process**: `kill -9 <PID>`
3. **Use different port**: Modify `package.json` scripts or use `npm run dev -- -p 3001`

### Permission Issues
1. **Check file ownership**: The container runs as `node` user
2. **Fix permissions**: 
   ```bash
   sudo chown -R $USER:$USER .
   ```

### Slow Performance
1. **Increase Docker resources**: Docker Desktop → Settings → Resources
2. **Use volume mounts**: Already configured for optimal performance
3. **Clear node_modules**: `rm -rf node_modules && npm install`

### VS Code Extensions Not Working
1. **Reload window**: `Ctrl+Shift+P` → "Developer: Reload Window"
2. **Reinstall extensions**: They should auto-install in container
3. **Check extension compatibility**: Some extensions may not work in containers

### DigitalOcean Integration Issues
1. **doctl not authenticated**:
   ```bash
   # Check if token is set
   echo $DIGITALOCEAN_ACCESS_TOKEN
   
   # Manually authenticate
   doctl auth init --access-token YOUR_TOKEN
   ```
2. **Environment variables not passed**:
   - Ensure token is set on host machine before starting container
   - Restart VS Code after setting environment variables
   - Check container environment: `env | grep DIGITALOCEAN`
3. **MCP server not working**:
   - Check if MCP package is installed: `npm list -g @digitalocean/mcp`
   - Test MCP server: `npx @digitalocean/mcp --help`
   - Test with specific services: `npx @digitalocean/mcp --services apps`
   - Reinstall if needed: `npm install -g @digitalocean/mcp`

## 🔄 Maintenance

### Updating the Container
1. **Update base image**: Edit `Dockerfile` to use newer Node.js version
2. **Update features**: Check for newer versions in `devcontainer.json`
3. **Rebuild**: `Ctrl+Shift+P` → "Dev Containers: Rebuild Container"

### Adding New Dependencies
```bash
# Add runtime dependency
npm install <package-name>

# Add development dependency
npm install --save-dev <package-name>
```

### Updating Documentation
When you modify the DevContainer configuration:
1. Update this `DEVCONTAINER.md` file
2. Test the changes by rebuilding the container
3. Document any new features or requirements

## 📚 Additional Resources

- [DevContainer Specification](https://containers.dev/implementors/spec/)
- [VS Code DevContainers Documentation](https://code.visualstudio.com/docs/remote/containers)
- [Docker Documentation](https://docs.docker.com/)
- [Next.js Documentation](https://nextjs.org/docs)

## 🆘 Getting Help

If you encounter issues:
1. Check the [troubleshooting section](#🐛-troubleshooting) above
2. Review Docker Desktop logs
3. Check VS Code DevContainer logs: `Ctrl+Shift+P` → "Dev Containers: Show Container Log"
4. Create an issue in the repository with:
   - Your operating system
   - Docker Desktop version
   - VS Code version
   - Error messages or logs

---

**Happy coding! 🎉** The DevContainer setup provides everything you need for Next.js development with this documentation site.
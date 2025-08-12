# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

- **Development server**: `npm run dev` - Starts Next.js development server on http://localhost:3000
- **Build**: `npm run build` - Creates production build
- **Start production**: `npm start` - Runs production server
- **Linting**: `npm run lint` - Runs ESLint with Next.js configuration

## Architecture Overview

This is a **Next.js documentation site** built with the Tailwind Plus Protocol template. It serves as an API documentation website with the following key architectural components:

### Core Architecture
- **Next.js App Router**: Uses the modern app directory structure (`src/app/`)
- **MDX-based Documentation**: All documentation pages are written in MDX format (`page.mdx` files)
- **Dynamic Navigation**: Navigation is automatically generated from MDX file structure
- **Full-text Search**: Powered by FlexSearch with automatic indexing of all MDX content

### Key Components
- **Layout System**: Main layout (`src/components/Layout.tsx`) provides sidebar navigation and responsive design
- **MDX Processing**: Custom MDX pipeline with search indexing (`src/mdx/search.mjs`)
- **Theme Support**: Dark/light theme toggle using next-themes
- **Component Library**: Reusable UI components in `src/components/`

### Content Structure
- Documentation pages are organized in `src/app/` as MDX files
- Each `page.mdx` file exports metadata and sections for navigation
- Search indexing automatically scans all MDX content for full-text search functionality

### Styling
- **Tailwind CSS**: Uses Tailwind v4 with custom configuration
- **Typography**: Custom typography system with prose styling for content
- **Responsive Design**: Mobile-first responsive layout with sidebar navigation

### Search Implementation
The search system (`src/mdx/search.mjs`) automatically:
- Scans all MDX files during build
- Extracts headings and content for indexing
- Creates a FlexSearch document index
- Enables real-time search with keyboard shortcuts (⌘K)

### Path Aliases
- `@/*` maps to `src/*` (configured in `tsconfig.json`)
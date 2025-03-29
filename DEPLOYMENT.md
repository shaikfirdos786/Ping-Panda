# Ping Panda Deployment Guide

This guide provides comprehensive instructions for deploying the Ping Panda application to various environments.

## Deployment Options

### 1. Cloudflare Workers Deployment (Recommended)

Ping Panda is configured to work with Cloudflare Workers out of the box. This is the recommended deployment method.

#### Prerequisites
- Cloudflare account
- Wrangler CLI installed (`npm install -g wrangler`)
- Cloudflare API token with Workers permissions

#### Deployment Steps
1. Update `wrangler.toml` with your project name
2. Set up environment variables in Cloudflare dashboard or using wrangler
3. Run `pnpm deploy` to deploy the application

### 2. Traditional Node.js Server Deployment

You can also deploy Ping Panda as a traditional Node.js application.

#### Prerequisites
- Node.js server (v18 or higher recommended)
- PM2 or similar process manager (optional but recommended)

#### Deployment Steps
1. Build the application: `pnpm build`
2. Start the server: `pnpm start`
3. For production, use a process manager like PM2: `pm2 start npm -- start`

### 3. Docker Deployment

While not included out of the box, you can containerize Ping Panda for deployment using Docker.

#### Sample Dockerfile
```dockerfile
FROM node:20-alpine AS base
RUN npm install -g pnpm

FROM base AS dependencies
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

FROM base AS build
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .
RUN pnpm build

FROM base AS deploy
WORKDIR /app
COPY --from=build /app/.next/standalone ./
COPY --from=build /app/public ./public
COPY --from=build /app/.next/static ./.next/static
EXPOSE 3000
CMD ["node", "server.js"]
```

## Creating Deployment Packages

### Source Package
To create a source code package for manual deployment:

**Windows:**
```
.\create-source-package.ps1
```

**Linux/Mac:**
```
chmod +x ./create-source-package.sh
./create-source-package.sh
```

### Build Package
To create a build package for deployment:

**Windows:**
```
.\create-build-package.ps1
```

**Linux/Mac:**
```
chmod +x ./create-build-package.sh
./create-build-package.sh
```

> **Note**: Build packages are not stored in the Git repository due to their large size (>100MB). You need to generate them locally using the scripts above before deployment.

## Environment Variables

For a complete list of required environment variables, refer to the `ENVIRONMENT_VARIABLES.md` file.

## Continuous Integration/Deployment

A GitHub Actions workflow is included in `.github/workflows/deploy.yml` for continuous deployment to Cloudflare Workers.

### Setting Up GitHub Actions
1. Add the required secrets to your GitHub repository:
   - `DATABASE_URL`
   - `CLOUDFLARE_API_TOKEN`
   - Other environment variables as needed
2. Push to the `main` branch to trigger the deployment workflow

## Troubleshooting

### Common Issues

1. **Build Fails with TypeScript Errors**
   - Fix the TypeScript errors in the codebase
   - Check the file `/src/app/dashboard/category/[name]/page.tsx` for type issues

2. **Environment Variable Missing**
   - Ensure all required environment variables are set
   - Check `ENVIRONMENT_VARIABLES.md` for a complete list

3. **Cloudflare Workers Deployment Fails**
   - Verify your Cloudflare API token has the correct permissions
   - Check that the project name in `wrangler.toml` is unique and available

### Getting Help

If you encounter issues not covered in this guide, please check:
- The project's GitHub repository issues section
- Cloudflare Workers documentation for worker-specific issues
- Next.js documentation for framework-specific questions 
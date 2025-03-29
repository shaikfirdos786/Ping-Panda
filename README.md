STAR THE REPO IF YOURE COOL

jStack - an opinionated stack to ship high-performance, low-cost Next.js apps inspired by the T3 stack.

This is an early-stage stack so probably dont use in production yet. If you're wild enough to do so despite this warning, let me know your website URL so I can feature you lol

documentation coming soon, for now just clone this repo, fill out the .env.example :))

# Ping Panda

A Next.js application with Cloudflare Workers integration.

## Deployment Instructions

### Prerequisites
- Node.js (v18 or higher recommended)
- pnpm package manager
- Cloudflare account (for worker deployment)
- Neon PostgreSQL database
- Clerk account (for authentication)
- Optional: Upstash Redis (for caching)

### Environment Setup
1. Clone the repository
2. Copy `.env.example` to `.env` and fill in the required environment variables:
   - `DATABASE_URL`: Your Neon PostgreSQL database connection string
   - `REDIS_URL` and `REDIS_TOKEN`: Optional Upstash Redis credentials for caching
   - Clerk authentication credentials

### Build for Production
1. Install dependencies:
   ```
   pnpm install
   ```

2. Build the application:
   ```
   pnpm build
   ```

3. Deploy to Cloudflare Workers (make sure to update the project name in wrangler.toml first):
   ```
   pnpm deploy
   ```

4. Alternatively, for non-Cloudflare deployment, you can start the production server:
   ```
   pnpm start
   ```

### Additional Notes
- Make sure all environment variables are properly set in your production environment
- The application uses Prisma with Neon PostgreSQL, ensure your database is properly set up
- For complete CI/CD setup, consider using GitHub Actions with the workflows provided

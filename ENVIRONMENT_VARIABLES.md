# Environment Variables for Ping Panda

This document lists all the environment variables required for the proper deployment and operation of Ping Panda.

## Required Environment Variables

### Database Connection
- `DATABASE_URL`: PostgreSQL connection string (recommended: Neon.tech)

### Authentication (Clerk)
- `NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY`: Clerk publishable key
- `CLERK_SECRET_KEY`: Clerk secret key
- `CLERK_WEBHOOK_SECRET`: Secret for Clerk webhooks

### API URLs
- `NEXT_PUBLIC_API_URL`: Public API URL for client-side requests

## Optional Environment Variables

### Caching (Upstash Redis)
- `REDIS_URL`: Upstash Redis URL
- `REDIS_TOKEN`: Upstash Redis token

### Cloudflare Deployment
- `CLOUDFLARE_API_TOKEN`: API token for Cloudflare Workers deployment
- `CLOUDFLARE_ACCOUNT_ID`: Your Cloudflare account ID

### Payment Processing (Stripe)
- `STRIPE_SECRET_KEY`: Stripe API secret key
- `STRIPE_WEBHOOK_SECRET`: Secret for Stripe webhooks
- `NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY`: Stripe publishable key

## Setting Up Environment Variables

### Local Development
1. Copy `.env.example` to `.env`
2. Fill in all required variables

### Production Deployment
1. Set these environment variables in your hosting platform (Cloudflare)
2. For GitHub Actions deployment, add these as repository secrets

### Environment Variables Reference
For a complete reference of all environment variables used in the application, check the `.env.example` file and the configuration files in the codebase. 
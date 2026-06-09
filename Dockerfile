FROM mirror.gcr.io/library/node:22-alpine AS builder
WORKDIR /app

# Install pnpm version 9 as required by local prerequisites
RUN npm install -g pnpm@9

# Copy lockfile and package.json
COPY package.json pnpm-lock.yaml* ./

# Use --no-frozen-lockfile to avoid lockfile mismatch
RUN pnpm install --no-frozen-lockfile

COPY . .

# Patch next.config.ts to ensure standalone output for production container
# The original attempt used sed on .config.* which might miss .ts files or fail on syntax
# We use a more robust approach to inject output: 'standalone'
RUN sed -i "s/const nextConfig: NextConfig = {/const nextConfig: NextConfig = {\n  output: 'standalone',/g" next.config.ts 2>/dev/null || true

# Set build-time environment variables to prevent build failures (based on .env.example)
ENV NEXT_PUBLIC_APP_URL=https://placeholder.nexlayer.ai
ENV NODE_OPTIONS="--max-old-space-size=8192"

# Build the application
RUN pnpm build

FROM mirror.gcr.io/library/node:22-alpine
WORKDIR /app

ENV NODE_ENV=production
ENV HOSTNAME=0.0.0.0
ENV PORT=3000

# Copy standalone build files
# In Next.js standalone mode, the server.js and node_modules are in .next/standalone
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

EXPOSE 3000

CMD ["node", "server.js"]
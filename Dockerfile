# ---------------------------------------
# 1. Build Next.js frontend
# ---------------------------------------
FROM node:18-alpine AS frontend
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm ci --only=production
COPY frontend .
RUN npm run build

# ---------------------------------------
# 2. Setup backend with frontend build
# ---------------------------------------
FROM node:18-alpine AS backend
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache \
    curl \
    && rm -rf /var/cache/apk/*

# Install backend dependencies
COPY package*.json ./
COPY prisma ./prisma/
RUN npm ci --only=production && npx prisma generate

# Copy all backend files
COPY . .

# Copy Next.js build output to backend
COPY --from=frontend /app/frontend/.next ./frontend/.next
COPY --from=frontend /app/frontend/public ./frontend/public
COPY --from=frontend /app/frontend/package.json ./frontend/

# Create necessary directories
RUN mkdir -p logs backups

# Set permissions
RUN chown -R node:node /app
USER node

# ---------------------------------------
# 3. Run the integrated server
# ---------------------------------------
EXPOSE 5000

# Enhanced health check for Coolify
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:5000/welcome || exit 1

CMD ["node", "server.js"]
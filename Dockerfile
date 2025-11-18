##############
#  BUILDER   #
##############
FROM node:24 AS builder
WORKDIR /app

# Tylko pliki zależności
COPY ./app/package*.json ./

# Instalujemy *tylko* prod deps
RUN npm ci --omit=dev

# Kopiujemy kod
COPY ./app .

# Build Next.js
RUN npm run build


##############
#  RUNTIME   #
##############
FROM node:24-alpine AS runtime
WORKDIR /app

# Wrzucamy production package.json
COPY --from=builder /app/package.json ./

# Instalujemy tylko production deps (bez dev, bez builder deps)
RUN npm ci --omit=dev

# Copy built assets
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

# Non-root user
RUN adduser -D nextjs
USER nextjs

CMD ["npm", "start"]
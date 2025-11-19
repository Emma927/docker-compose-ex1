# 1️⃣ Builder stage
FROM node:24 AS builder
WORKDIR /app

# Kopiujemy tylko package.json i package-lock.json (szybszy build)
COPY ./app/package*.json ./

# Instalujemy tylko produkcyjne zależności
RUN npm install --production

# Kopiujemy cały kod źródłowy
COPY ./app ./

# Budujemy aplikację Next.js
RUN npm run build

# 2️⃣ Finalny stage (runtime)
FROM node:24-alpine
WORKDIR /app

# Kopiujemy build i public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

# Kopiujemy package.json i node_modules z buildera (z tylko produkcyjnymi deps)
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules

# Ustawienie użytkownika
RUN adduser -D nextjs
USER nextjs

# Uruchomienie aplikacji
CMD ["npm", "start"]


# FROM node:24 AS builder
# WORKDIR /app
# COPY ./app/package*.json . 
# RUN npm install
# COPY ./app .
# RUN npm run build
# 
# FROM node:24-alpine
# WORKDIR /app
# COPY --from=builder /app/.next ./.next
# COPY --from=builder /app/public ./public
# COPY --from=builder /app/package.json ./package.json
# 
# # Robimy npm install next przed zmianą użytkownka z root na nextjs, aby nie miećproblemów z upranieniami 
# RUN npm install next
# 
# RUN adduser -D nextjs
# USER nextjs
# #RUN npm install next
# CMD ["npm", "start"]


# ##############
# #  BUILDER   #
# ##############
# FROM node:24 AS builder
# WORKDIR /app
# 
# # Tylko pliki zależności
# COPY ./app/package*.json ./
# 
# # Instalujemy production deps (bez dev)
# RUN npm ci --omit=dev
# 
# # Kopiujemy cały kod źródłowy
# COPY ./app ./
# 
# # Build Next.js (tutaj devDependencies mogą być tymczasowo pobrane przez Next)
# RUN npm run build
# 
# 
# ##############
# #  RUNTIME   #
# ##############
# FROM node:24-alpine AS runtime
# WORKDIR /app
# 
# # Kopiujemy package.json i package-lock.json z buildera
# COPY --from=builder /app/package.json ./
# COPY --from=builder /app/package-lock.json ./
# 
# # Instalujemy tylko production dependencies
# RUN npm ci --omit=dev
# 
# # Kopiujemy built assets
# COPY --from=builder /app/.next ./.next
# COPY --from=builder /app/public ./public
# 
# # Tworzymy non-root user
# RUN adduser -D nextjs
# USER nextjs
# 
# # Uruchamiamy aplikację
# CMD ["npm", "start"]

FROM node:21 AS builder
WORKDIR /app
COPY ./app/package*.json . 
RUN npm install
COPY ./app .
RUN npm run build

FROM node:21-alpine
WORKDIR /app
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json

# Robimy npm install next przed zmianą użytkownka z root na nextjs, aby nie miećproblemów z upranieniami 
RUN npm install next

RUN adduser -D nextjs
USER nextjs
#RUN npm install next
CMD ["npm", "start"]


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

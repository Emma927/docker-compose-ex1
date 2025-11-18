FROM node:24 AS builder
WORKDIR /app
COPY ./app/package*.json . 
RUN npm install
COPY ./app .
RUN npm run build

FROM node:24-alpine
WORKDIR /app

# 🔹 Aktualizacja pakietów systemowych, żeby zmniejszyć podatności
# RUN apk update && apk upgrade

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json

# Robimy npm install next przed zmianą użytkownka z root na nextjs, aby nie miećproblemów z upranieniami 
RUN npm install next

RUN adduser -D nextjs
USER nextjs
#RUN npm install next
CMD ["npm", "start"]
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app .
USER node
EXPOSE 8086
CMD ["node", "index.js"]
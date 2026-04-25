# Stage 1: Build & Test
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm test

# Stage 2: Production Environment
FROM node:18-slim
WORKDIR /app
# คัดลอกเฉพาะไฟล์ที่จำเป็นมาจาก Stage builder
COPY --from=builder /app/index.js ./
COPY --from=builder /app/package*.json ./
# ติดตั้งเฉพาะ Production dependencies (ไม่มี Jest/Supertest)
RUN npm ci --only=production

EXPOSE 3000
CMD ["node", "index.js"]


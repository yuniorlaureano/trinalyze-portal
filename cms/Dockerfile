# Production image for the Strapi backend.
# Build once, run with real secrets injected at container runtime
# (see docker-compose.prod.yml at the repo root).

FROM node:22-alpine AS build
# sharp (Strapi's image-processing lib) needs libvips to compile/run.
RUN apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git python3
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
ENV NODE_ENV=production
RUN npm run build

FROM node:22-alpine
RUN apk add --no-cache vips
WORKDIR /app
ENV NODE_ENV=production
COPY --from=build /app ./
RUN npm prune --omit=dev && chown -R node:node /app
USER node

EXPOSE 1337
CMD ["npm", "run", "start"]

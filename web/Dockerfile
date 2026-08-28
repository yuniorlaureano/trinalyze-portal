# Production image for the Astro frontend (Node adapter, standalone mode).
#
# PUBLIC_STRAPI_URL must be supplied as a build ARG (not just a runtime env
# var): Vite inlines `import.meta.env.PUBLIC_*` values into the client
# bundle at build time, since that code ships to the browser. Changing it
# later requires rebuilding this image — see docker-compose.prod.yml.

FROM node:22-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
ARG PUBLIC_STRAPI_URL
ENV PUBLIC_STRAPI_URL=${PUBLIC_STRAPI_URL}
RUN npm run build

FROM node:22-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY --from=build /app ./
RUN npm prune --omit=dev && chown -R node:node /app
USER node

ENV HOST=0.0.0.0
ENV PORT=4321
EXPOSE 4321
CMD ["node", "./dist/server/entry.mjs"]

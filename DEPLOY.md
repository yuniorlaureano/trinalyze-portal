# Despliegue en un VPS con Docker

Esta guía asume un VPS Linux (Ubuntu 22.04/24.04) recién provisionado, sin
dominio todavía — solo la IP pública del servidor. Si más adelante
consiguen un dominio, la sección final explica el cambio.

## 0. Requisitos en el VPS

Conéctate por SSH al servidor y confirma/instala lo siguiente:

```bash
# Docker + Docker Compose plugin (Ubuntu/Debian)
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
# cierra la sesión SSH y vuelve a entrar para que el grupo tome efecto

docker --version
docker compose version
```

Abre en el firewall los puertos que va a usar el stack (ajusta si usas
`ufw`, ` firewalld`, o el firewall del proveedor):

```bash
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 1337/tcp   # panel/API de Strapi, mientras no haya dominio
sudo ufw enable
```

## 1. Clonar el repositorio

```bash
git clone https://github.com/yuniorlaureano/trinalyze-portal.git
cd trinalyze-portal
```

## 2. Generar los secretos de producción

Strapi necesita sus propios secretos, **distintos a los de desarrollo**.
Genera cada uno así:

```bash
# Corre esto 4 veces y junta los resultados separados por coma -> APP_KEYS
openssl rand -base64 32

# Corre esto una vez por cada uno de estos: API_TOKEN_SALT,
# ADMIN_JWT_SECRET, JWT_SECRET, TRANSFER_TOKEN_SALT, ENCRYPTION_KEY
openssl rand -base64 32
```

## 3. Configurar las variables de entorno

```bash
cp .env.production.example .env
nano .env   # o vim/tu editor preferido
```

Completa:
- `DATABASE_PASSWORD` — una contraseña fuerte, nunca la de desarrollo.
- `APP_KEYS`, `API_TOKEN_SALT`, `ADMIN_JWT_SECRET`, `JWT_SECRET`,
  `TRANSFER_TOKEN_SALT`, `ENCRYPTION_KEY` — los que generaste en el paso 2.
- `PUBLIC_STRAPI_URL` — `http://<IP_DEL_VPS>:1337` (sin dominio todavía).

## 4. Levantar el stack

```bash
docker compose -f docker-compose.prod.yml up -d --build
```

La primera vez tarda varios minutos (compila el panel de Strapi y el
sitio de Astro). Revisa que los 4 servicios queden arriba:

```bash
docker compose -f docker-compose.prod.yml ps
```

## 5. Crear el primer usuario administrador

Abre `http://<IP_DEL_VPS>:1337/admin` en el navegador — como es la primera
vez, Strapi te pide crear la cuenta de administrador ahí mismo.

## 6. Cargar el contenido ilustrativo (opcional)

Si quieren arrancar con el mismo contenido de ejemplo que ya existe:

1. Crea un API Token de acceso completo desde el panel: **Settings → API
   Tokens → Create new API Token** (tipo "Full access").
2. Corre el script desde tu máquina (o desde el VPS) apuntando a la URL
   pública:

```bash
BASE_URL=http://<IP_DEL_VPS>:1337 STRAPI_API_TOKEN=<el-token> \
  ./cms/scripts/seed-illustrative.sh
```

3. Borra el token después de usarlo (Settings → API Tokens).

## 7. Verificar

- Sitio: `http://<IP_DEL_VPS>`
- Admin de Strapi: `http://<IP_DEL_VPS>:1337/admin`
- Formulario de contacto: envía una prueba desde `/contacto` y confírmala
  en **Content Manager → Contact Submission**.

## Actualizar el sitio (después de un cambio en el repo)

```bash
cd trinalyze-portal
git pull
docker compose -f docker-compose.prod.yml up -d --build
```

`--build` reconstruye solo lo que cambió. Si el cambio fue únicamente
contenido en Strapi (no código), no hace falta este paso.

⚠️ Si cambias `PUBLIC_STRAPI_URL` en `.env`, tienes que reconstruir
específicamente el frontend — ese valor queda incrustado en el sitio
compilado, no se lee en caliente:

```bash
docker compose -f docker-compose.prod.yml up -d --build web
```

## Respaldos

Los datos reales viven en dos volúmenes de Docker: `pgdata` (la base de
datos) y `strapi_uploads` (imágenes subidas). Respáldalos periódicamente:

```bash
docker run --rm -v trinalyze-portal_pgdata:/data -v $(pwd):/backup alpine \
  tar czf /backup/pgdata-backup-$(date +%F).tar.gz -C /data .
```

## Cuando consigan un dominio

1. Apunta el (o los) dominio(s) al registro A de la IP del VPS.
2. Edita [`Caddyfile`](Caddyfile): reemplaza los bloques `:80` y `:1337`
   por los nombres de dominio reales (ver los comentarios dentro del
   archivo) — Caddy obtiene el certificado HTTPS automáticamente, sin
   configuración adicional.
3. Actualiza `PUBLIC_STRAPI_URL` en `.env` al nuevo dominio HTTPS de
   Strapi.
4. Reconstruye y reinicia:

```bash
docker compose -f docker-compose.prod.yml up -d --build
```

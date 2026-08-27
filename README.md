# TRIN∆LYZE — Portal web

Portal corporativo de TRINALYZE SRL: consultoría tecnológica, desarrollo de
software, inteligencia artificial y business intelligence, con sede en
Santo Domingo, República Dominicana.

## Stack

| Parte | Tecnología | Carpeta |
|---|---|---|
| CMS / backend | [Strapi 5](https://strapi.io) (TypeScript) + Postgres | [`cms/`](cms) |
| Frontend | [Astro](https://astro.build) (TypeScript strict) + React (isla del formulario de contacto) | [`web/`](web) |
| Base de datos | Postgres 16, vía Docker Compose | [`docker-compose.yml`](docker-compose.yml) |
| Prototipo estático | HTML/CSS de referencia visual (previo a Astro) | [`prototype/`](prototype) |

Astro corre con el adaptador Node en modo `standalone` y consume la API
REST de Strapi — no hay contenido hardcodeado en el frontend, todo sale del
CMS.

## Cómo correrlo localmente

```bash
# 1. Base de datos (una sola vez, o cuando la reinicies)
docker compose up -d

# 2. Backend — panel admin en http://localhost:1337/admin
cd cms
npm install
npm run develop

# 3. Frontend — sitio en http://localhost:4321
cd web
npm install
cp .env.example .env   # ajusta STRAPI_URL / PUBLIC_STRAPI_URL si hace falta
npm run dev
```

## Modelo de contenido (Strapi)

| Content-Type | Tipo | Para qué |
|---|---|---|
| `Service` | Colección | Los 3 pilares (Data & Analytics, Technology, AI & Automation) |
| `Project` | Colección | Casos de estudio, formato problema / solución / resultado |
| `TeamMember` | Colección | CEO + 4 direcciones |
| `Sector` | Colección | Hospitalidad, PYMEs, Retail, Finanzas, Educación |
| `Post` | Colección | Artículos de Insights |
| `ContactSubmission` | Colección | Envíos del formulario "Solicitar diagnóstico" |
| `AboutPage` | Single Type | Qué Hacemos + Filosofía |
| `ProcessPage` | Single Type | Las 5 fases del proceso metodológico |

El arranque de Strapi ([`cms/src/index.ts`](cms/src/index.ts)) otorga
automáticamente permisos públicos de lectura sobre las colecciones y Single
Types, y de creación sobre `ContactSubmission` — así el frontend consume la
API sin necesitar un token.

### Contenido ilustrativo

[`cms/scripts/seed-illustrative.sh`](cms/scripts/seed-illustrative.sh) carga
vía API el mismo contenido de ejemplo que ya vive en `/prototype` (3
servicios, 3 proyectos ilustrativos, 5 direcciones, 5 sectores, 6 posts de
Insights, y las dos páginas únicas). Requiere un token de API con acceso
completo:

```bash
STRAPI_API_TOKEN=<token-full-access> ./cms/scripts/seed-illustrative.sh
```

## Páginas del sitio

| Página | Ruta | Contenido desde Strapi |
|---|---|---|
| Inicio | `/` | `AboutPage`, `Service`, `Project`, `Sector`, `Post` |
| Servicios | `/servicios` | `Service` (con `highlights`) |
| Soluciones | `/soluciones` | `ProcessPage` (5 fases) + `Sector` |
| Proyectos | `/proyectos` | `Project` |
| Equipo | `/equipo` | `TeamMember` + `AboutPage` (Filosofía) |
| Insights | `/insights` | `Post` |
| Contacto | `/contacto` | Formulario (isla de React) → `POST /api/contact-submissions` |

## Estado actual

- ✅ Backend (Strapi) y frontend (Astro) escafoldeados y conectados de punta
  a punta, incluyendo el envío del formulario de contacto.
- ✅ Contenido ilustrativo cargado para poder ver el sitio completo con
  datos reales (aunque de ejemplo).
- ⚠️ Los nombres de `TeamMember` son placeholders (repiten el nombre de la
  dirección) — falta reemplazarlos por los nombres reales de los socios.
- ⚠️ Los `Project` marcados `isIllustrative: true` y los `Post` de Insights
  son de ejemplo — hay que reemplazarlos por casos y artículos reales antes
  de publicar.
- ⏳ Pendiente: definir estrategia de hosting definitiva (autohospedado vs.
  administrado), ver [prototype feedback](revision%20de%20la%20pagina.pdf)
  y el plan original de la sesión de scaffolding.

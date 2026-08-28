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

Para desplegar esto en un VPS con Docker, ver [`DEPLOY.md`](DEPLOY.md).

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

Cada página del sitio es un **Single Type propio**, compuesto por
**Components** con nombre — uno por cada bloque visual de esa página. La
idea: al abrir cualquier Single Type en Strapi, la estructura se entiende
por los bloques (`hero`, `queHacemos`, `filosofia`, `ctaFinal`...) sin
necesidad de leer el contenido. Donde una sección necesita una lista que
crece con el tiempo (Proyectos, Insights), ese bloque no vive dentro de la
página — se resuelve consultando la Collection correspondiente aparte.

| Single Type (una página) | Bloques (Components) |
|---|---|
| `HomePage` | `hero`, `queHacemos` (+ `stats` anidado), `serviciosHeader`, `proyectosHeader`, `sectoresHeader`, `insightsHeader`, `ctaFinal` |
| `ServiciosPage` | `header`, `ctaFinal` |
| `SolucionesPage` | `header`, `phases` (las 5 fases), `ctaFinal` |
| `ProyectosPage` | `header`, `ctaFinal` |
| `EquipoPage` | `header`, `filosofia` |
| `InsightsPage` | `header` |
| `ContactoPage` | `header`, `whatsappLabel`, `footerNote` |

Components reutilizados entre páginas: `shared.section-header` (eyebrow +
heading + dek), `shared.cta-band`, `shared.stat`, `sections.hero`,
`sections.about`, `sections.filosofia`, `process.phase`.

| Collection Type | Para qué |
|---|---|
| `Service` | Los 3 pilares (Data & Analytics, Technology, AI & Automation) |
| `Project` | Casos de estudio, formato problema / solución / resultado |
| `TeamMember` | CEO + 4 direcciones |
| `Sector` | Hospitalidad, PYMEs, Retail, Finanzas, Educación |
| `Post` | Artículos de Insights |
| `ContactSubmission` | Envíos del formulario "Solicitar diagnóstico" |

Estas quedan como Collections (y no como Components dentro de una página)
porque crecen con el tiempo, se publican de a una, y `Post.author` incluso
referencia `TeamMember` — algo que un Component no puede hacer.

El arranque de Strapi ([`cms/src/index.ts`](cms/src/index.ts)) otorga
automáticamente permisos públicos de lectura sobre las colecciones y Single
Types, y de creación sobre `ContactSubmission` — así el frontend consume la
API sin necesitar un token.

### Contenido ilustrativo

[`cms/scripts/seed-illustrative.sh`](cms/scripts/seed-illustrative.sh) carga
vía API el mismo contenido de ejemplo que ya vive en `/prototype` (3
servicios, 3 proyectos ilustrativos, 5 direcciones, 5 sectores, 6 posts de
Insights, y los 7 Single Types de página). Requiere un token de API con
acceso completo:

```bash
STRAPI_API_TOKEN=<token-full-access> ./cms/scripts/seed-illustrative.sh
```

## Páginas del sitio

| Página | Ruta | Contenido desde Strapi |
|---|---|---|
| Inicio | `/` | `HomePage` + `Service`, `Project`, `Sector`, `Post` |
| Servicios | `/servicios` | `ServiciosPage` + `Service` (con `highlights`) |
| Soluciones | `/soluciones` | `SolucionesPage` (con `phases`) + `Sector` |
| Proyectos | `/proyectos` | `ProyectosPage` + `Project` |
| Equipo | `/equipo` | `EquipoPage` + `TeamMember` |
| Insights | `/insights` | `InsightsPage` + `Post` |
| Contacto | `/contacto` | `ContactoPage` + formulario (isla de React) → `POST /api/contact-submissions` |

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

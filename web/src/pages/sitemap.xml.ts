// Generated per-request (same as every other page) rather than a static
// build-time file, because /insights/[slug] entries live in Strapi and
// can be added without a rebuild. getPosts() is already cached, so this
// doesn't add real load.
import type { APIRoute } from 'astro';
import { getPosts } from '../lib/strapi';

const STATIC_PATHS = ['/', '/servicios', '/soluciones', '/proyectos', '/equipo', '/insights', '/contacto'];

export const GET: APIRoute = async ({ site }) => {
  const base = site?.origin ?? 'https://trinalyze.com';
  const posts = await getPosts();

  const urls = [
    ...STATIC_PATHS.map((path) => `${base}${path}`),
    ...posts.map((post) => `${base}/insights/${post.slug}`),
  ];

  const body = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map((url) => `  <url><loc>${url}</loc></url>`).join('\n')}
</urlset>
`;

  return new Response(body, {
    status: 200,
    headers: { 'content-type': 'application/xml' },
  });
};

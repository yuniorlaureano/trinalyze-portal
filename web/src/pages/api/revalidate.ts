// Strapi calls this on every entry create/update/publish/delete (see the
// webhook setup in DEPLOY.md). We don't bother inspecting which
// content-type changed — the cache is small and clearing all of it is
// simpler and safer than trying to invalidate just the affected key.
import type { APIRoute } from 'astro';
import { invalidateCache } from '../../lib/strapi';

const REVALIDATE_SECRET = process.env.REVALIDATE_SECRET;

export const POST: APIRoute = async ({ request }) => {
  if (REVALIDATE_SECRET) {
    const provided = request.headers.get('x-revalidate-secret') ?? new URL(request.url).searchParams.get('secret');
    if (provided !== REVALIDATE_SECRET) {
      return new Response(JSON.stringify({ error: 'unauthorized' }), { status: 401 });
    }
  }

  invalidateCache();
  return new Response(JSON.stringify({ revalidated: true }), {
    status: 200,
    headers: { 'content-type': 'application/json' },
  });
};

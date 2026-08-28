// @ts-check
import { defineConfig } from 'astro/config';

import node from '@astrojs/node';
import react from '@astrojs/react';

// https://astro.build/config
export default defineConfig({
  // Every page renders per-request against live Strapi content — without
  // this, Astro prerenders pages to static HTML at build time and edits
  // made in Strapi would never show up until the next rebuild.
  output: 'server',

  adapter: node({
    mode: 'standalone'
  }),

  integrations: [react()]
});
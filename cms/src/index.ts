import type { Core } from '@strapi/strapi';

// Content the public (unauthenticated) role is allowed to read.
const PUBLIC_READ_ACTIONS = [
  'api::service.service.find',
  'api::service.service.findOne',
  'api::project.project.find',
  'api::project.project.findOne',
  'api::team-member.team-member.find',
  'api::team-member.team-member.findOne',
  'api::sector.sector.find',
  'api::sector.sector.findOne',
  'api::post.post.find',
  'api::post.post.findOne',
  'api::home-page.home-page.find',
  'api::servicios-page.servicios-page.find',
  'api::soluciones-page.soluciones-page.find',
  'api::proyectos-page.proyectos-page.find',
  'api::equipo-page.equipo-page.find',
  'api::insights-page.insights-page.find',
  'api::contacto-page.contacto-page.find',
];

// The only write the public role is allowed to do: submit the contact form.
const PUBLIC_CREATE_ACTIONS = ['api::contact-submission.contact-submission.create'];

export default {
  /**
   * An asynchronous register function that runs before
   * your application is initialized.
   *
   * This gives you an opportunity to extend code.
   */
  register(/* { strapi }: { strapi: Core.Strapi } */) {},

  /**
   * An asynchronous bootstrap function that runs before
   * your application gets started.
   *
   * Grants the public role read access to the site's content types and
   * write access to the contact form, so the Astro frontend can call the
   * REST API without an API token in development. Safe to re-run: it
   * skips any permission that already exists.
   */
  async bootstrap({ strapi }: { strapi: Core.Strapi }) {
    const publicRole = await strapi.db
      .query('plugin::users-permissions.role')
      .findOne({ where: { type: 'public' } });

    if (!publicRole) {
      strapi.log.warn('[bootstrap] Public role not found, skipping permission setup');
      return;
    }

    const actions = [...PUBLIC_READ_ACTIONS, ...PUBLIC_CREATE_ACTIONS];

    for (const action of actions) {
      const existing = await strapi.db.query('plugin::users-permissions.permission').findOne({
        where: { action, role: publicRole.id },
      });

      if (!existing) {
        await strapi.db.query('plugin::users-permissions.permission').create({
          data: { action, role: publicRole.id },
        });
        strapi.log.info(`[bootstrap] Granted public permission: ${action}`);
      }
    }
  },
};

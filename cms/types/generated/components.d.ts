import type { Schema, Struct } from '@strapi/strapi';

export interface ProcessPhase extends Struct.ComponentSchema {
  collectionName: 'components_process_phases';
  info: {
    description: 'One phase of the 5-phase TRINALYZE methodology';
    displayName: 'Phase';
    icon: 'flag';
  };
  attributes: {
    detail: Schema.Attribute.String & Schema.Attribute.Required;
    numeral: Schema.Attribute.String & Schema.Attribute.Required;
    question: Schema.Attribute.String & Schema.Attribute.Required;
    title: Schema.Attribute.String & Schema.Attribute.Required;
  };
}

export interface SectionsAbout extends Struct.ComponentSchema {
  collectionName: 'components_sections_abouts';
  info: {
    description: 'Who-we-are block with supporting stats';
    displayName: 'About (Qu\u00E9 Hacemos)';
    icon: 'information';
  };
  attributes: {
    body: Schema.Attribute.RichText & Schema.Attribute.Required;
    heading: Schema.Attribute.String & Schema.Attribute.Required;
    stats: Schema.Attribute.Component<'shared.stat', true>;
  };
}

export interface SectionsFilosofia extends Struct.ComponentSchema {
  collectionName: 'components_sections_filosofias';
  info: {
    description: 'Company philosophy block, shown on the Equipo page';
    displayName: 'Filosof\u00EDa';
    icon: 'puzzle';
  };
  attributes: {
    body: Schema.Attribute.RichText & Schema.Attribute.Required;
    heading: Schema.Attribute.String & Schema.Attribute.Required;
  };
}

export interface SectionsHero extends Struct.ComponentSchema {
  collectionName: 'components_sections_heroes';
  info: {
    description: 'Home page hero block';
    displayName: 'Hero';
    icon: 'rocket';
  };
  attributes: {
    eyebrow: Schema.Attribute.String & Schema.Attribute.Required;
    heading: Schema.Attribute.Text & Schema.Attribute.Required;
    lede: Schema.Attribute.Text & Schema.Attribute.Required;
    primaryCtaHref: Schema.Attribute.String &
      Schema.Attribute.Required &
      Schema.Attribute.DefaultTo<'/contacto'>;
    primaryCtaLabel: Schema.Attribute.String & Schema.Attribute.Required;
    secondaryCtaHref: Schema.Attribute.String;
    secondaryCtaLabel: Schema.Attribute.String;
  };
}

export interface SharedCtaBand extends Struct.ComponentSchema {
  collectionName: 'components_shared_cta_bands';
  info: {
    description: 'Closing call-to-action block shown at the bottom of a page';
    displayName: 'CTA Band';
    icon: 'cursor';
  };
  attributes: {
    buttonHref: Schema.Attribute.String &
      Schema.Attribute.Required &
      Schema.Attribute.DefaultTo<'/contacto'>;
    buttonLabel: Schema.Attribute.String & Schema.Attribute.Required;
    eyebrow: Schema.Attribute.String;
    heading: Schema.Attribute.String & Schema.Attribute.Required;
  };
}

export interface SharedSectionHeader extends Struct.ComponentSchema {
  collectionName: 'components_shared_section_headers';
  info: {
    description: 'Eyebrow + heading + optional short intro, used at the top of a page section';
    displayName: 'Section Header';
    icon: 'layout';
  };
  attributes: {
    dek: Schema.Attribute.Text;
    eyebrow: Schema.Attribute.String & Schema.Attribute.Required;
    heading: Schema.Attribute.String & Schema.Attribute.Required;
  };
}

export interface SharedStat extends Struct.ComponentSchema {
  collectionName: 'components_shared_stats';
  info: {
    description: 'Small labeled number/value, e.g. Santo Domingo, RD / Sede central';
    displayName: 'Stat';
    icon: 'chartBubble';
  };
  attributes: {
    label: Schema.Attribute.String & Schema.Attribute.Required;
    value: Schema.Attribute.String & Schema.Attribute.Required;
  };
}

declare module '@strapi/strapi' {
  export namespace Public {
    export interface ComponentSchemas {
      'process.phase': ProcessPhase;
      'sections.about': SectionsAbout;
      'sections.filosofia': SectionsFilosofia;
      'sections.hero': SectionsHero;
      'shared.cta-band': SharedCtaBand;
      'shared.section-header': SharedSectionHeader;
      'shared.stat': SharedStat;
    }
  }
}

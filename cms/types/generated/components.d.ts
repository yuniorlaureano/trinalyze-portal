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

declare module '@strapi/strapi' {
  export namespace Public {
    export interface ComponentSchemas {
      'process.phase': ProcessPhase;
    }
  }
}

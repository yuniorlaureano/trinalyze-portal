// Small lookup tables shared by more than one page/component, so the
// icon/color for a given pillar or Insights category is defined once.

export const PILLAR_ICON: Record<string, { color: string; path: string }> = {
  'Data & Analytics': {
    color: 'var(--blue)',
    path: '<line x1="4" y1="20" x2="4" y2="11"></line><line x1="12" y1="20" x2="12" y2="5"></line><line x1="20" y1="20" x2="20" y2="14"></line>',
  },
  Technology: {
    color: 'var(--ink-soft)',
    path: '<rect x="7" y="7" width="10" height="10" rx="1.5"></rect><line x1="10" y1="2" x2="10" y2="7"></line><line x1="14" y1="2" x2="14" y2="7"></line><line x1="10" y1="17" x2="10" y2="22"></line><line x1="14" y1="17" x2="14" y2="22"></line><line x1="2" y1="10" x2="7" y2="10"></line><line x1="2" y1="14" x2="7" y2="14"></line><line x1="17" y1="10" x2="22" y2="10"></line><line x1="17" y1="14" x2="22" y2="14"></line>',
  },
  'AI & Automation': {
    color: 'var(--mint)',
    path: '<circle cx="6" cy="6" r="2.2"></circle><circle cx="18" cy="6" r="2.2"></circle><circle cx="12" cy="18" r="2.2"></circle><line x1="7.6" y1="7.4" x2="10.6" y2="16"></line><line x1="16.4" y1="7.4" x2="13.4" y2="16"></line><line x1="8.2" y1="6" x2="15.8" y2="6"></line>',
  },
};

export const CATEGORY_COLOR: Record<string, string> = {
  IA: 'var(--mint)',
  BI: 'var(--blue)',
  Automatizacion: 'var(--mint)',
  Data: 'var(--blue)',
};

// The enum values stored in Strapi are plain ASCII (no accents, since
// Strapi enumeration values can't contain them) — this is what a human
// actually reads in the category filter on /insights.
export const CATEGORY_LABEL: Record<string, string> = {
  IA: 'IA',
  BI: 'BI',
  Automatizacion: 'Automatización',
  Data: 'Data',
};

export const POST_CATEGORIES = ['Data', 'IA', 'BI', 'Automatizacion'] as const;

// Thin fetch helper for the Strapi REST API. Runs server-side (in .astro
// frontmatter), so it uses the private STRAPI_URL — not the PUBLIC_ one,
// which is reserved for client-side code (see the ContactForm island).

const STRAPI_URL = import.meta.env.STRAPI_URL ?? 'http://localhost:1337';

interface StrapiListResponse<T> {
  data: T[];
  meta: { pagination: { page: number; pageSize: number; pageCount: number; total: number } };
}

interface StrapiSingleResponse<T> {
  data: T | null;
}

async function request<T>(path: string): Promise<T> {
  const res = await fetch(`${STRAPI_URL}${path}`);
  if (res.status === 404) {
    // Single types with no entry yet come back 404 — treat as "no data"
    // rather than throwing, so a page can still render with a fallback.
    return null as T;
  }
  if (!res.ok) {
    throw new Error(`Strapi request failed: GET ${path} -> ${res.status}`);
  }
  return res.json();
}

// ---------- shared components ----------

export interface SectionHeader {
  eyebrow: string;
  heading: string;
  dek: string | null;
}

export interface CtaBand {
  eyebrow: string | null;
  heading: string;
  buttonLabel: string;
  buttonHref: string;
}

export interface Stat {
  value: string;
  label: string;
}

export interface Hero {
  eyebrow: string;
  heading: string;
  lede: string;
  primaryCtaLabel: string;
  primaryCtaHref: string;
  secondaryCtaLabel: string | null;
  secondaryCtaHref: string | null;
}

export interface AboutSection {
  heading: string;
  body: string;
  stats: Stat[];
}

export interface FilosofiaSection {
  heading: string;
  body: string;
}

export interface ProcessPhase {
  id: number;
  numeral: string;
  title: string;
  question: string;
  detail: string;
}

// ---------- collections ----------

export interface Service {
  id: number;
  title: string;
  slug: string;
  pillar: 'Data & Analytics' | 'Technology' | 'AI & Automation';
  summary: string | null;
  description: string | null;
  highlights: string[] | null;
  order: number;
}

export interface Project {
  id: number;
  title: string;
  slug: string;
  sector: string;
  city: string | null;
  problem: string;
  solution: string;
  result: string;
  isIllustrative: boolean;
  order: number;
}

export interface TeamMember {
  id: number;
  name: string;
  direction: string;
  roleSummary: string | null;
  initials: string | null;
  bio: string | null;
  order: number;
}

export interface Sector {
  id: number;
  name: string;
  slug: string;
  description: string | null;
  order: number;
}

export interface Post {
  id: number;
  title: string;
  slug: string;
  category: 'Data' | 'IA' | 'BI' | 'Automatizacion';
  excerpt: string;
  body: string;
  publishedDate: string | null;
}

// ---------- pages (single types) ----------

export interface HomePage {
  hero: Hero;
  queHacemos: AboutSection;
  serviciosHeader: SectionHeader;
  proyectosHeader: SectionHeader;
  sectoresHeader: SectionHeader;
  insightsHeader: SectionHeader;
  ctaFinal: CtaBand;
}

export interface ServiciosPage {
  header: SectionHeader;
  ctaFinal: CtaBand;
}

export interface SolucionesPage {
  header: SectionHeader;
  phases: ProcessPhase[];
  ctaFinal: CtaBand;
}

export interface ProyectosPage {
  header: SectionHeader;
  ctaFinal: CtaBand;
}

export interface EquipoPage {
  header: SectionHeader;
  filosofia: FilosofiaSection;
}

export interface InsightsPage {
  header: SectionHeader;
}

export interface ContactoPage {
  header: SectionHeader;
  whatsappLabel: string;
  footerNote: string;
}

function sortByOrder<T extends { order: number }>(items: T[]): T[] {
  return [...items].sort((a, b) => a.order - b.order);
}

// ---------- collection getters ----------

export async function getServices(): Promise<Service[]> {
  const res = await request<StrapiListResponse<Service>>('/api/services?pagination[pageSize]=100');
  return sortByOrder(res?.data ?? []);
}

export async function getProjects(): Promise<Project[]> {
  const res = await request<StrapiListResponse<Project>>('/api/projects?pagination[pageSize]=100');
  return sortByOrder(res?.data ?? []);
}

export async function getTeamMembers(): Promise<TeamMember[]> {
  const res = await request<StrapiListResponse<TeamMember>>('/api/team-members?pagination[pageSize]=100');
  return sortByOrder(res?.data ?? []);
}

export async function getSectors(): Promise<Sector[]> {
  const res = await request<StrapiListResponse<Sector>>('/api/sectors?pagination[pageSize]=100');
  return sortByOrder(res?.data ?? []);
}

export async function getPosts(): Promise<Post[]> {
  const res = await request<StrapiListResponse<Post>>('/api/posts?pagination[pageSize]=100&sort=publishedDate:desc');
  return res?.data ?? [];
}

// ---------- page getters ----------

export async function getHomePage(): Promise<HomePage | null> {
  const res = await request<StrapiSingleResponse<HomePage>>(
    '/api/home-page?populate[hero]=true&populate[queHacemos][populate]=*&populate[serviciosHeader]=true&populate[proyectosHeader]=true&populate[sectoresHeader]=true&populate[insightsHeader]=true&populate[ctaFinal]=true'
  );
  return res?.data ?? null;
}

export async function getServiciosPage(): Promise<ServiciosPage | null> {
  const res = await request<StrapiSingleResponse<ServiciosPage>>(
    '/api/servicios-page?populate[header]=true&populate[ctaFinal]=true'
  );
  return res?.data ?? null;
}

export async function getSolucionesPage(): Promise<SolucionesPage | null> {
  const res = await request<StrapiSingleResponse<SolucionesPage>>(
    '/api/soluciones-page?populate[header]=true&populate[phases]=true&populate[ctaFinal]=true'
  );
  return res?.data ?? null;
}

export async function getProyectosPage(): Promise<ProyectosPage | null> {
  const res = await request<StrapiSingleResponse<ProyectosPage>>(
    '/api/proyectos-page?populate[header]=true&populate[ctaFinal]=true'
  );
  return res?.data ?? null;
}

export async function getEquipoPage(): Promise<EquipoPage | null> {
  const res = await request<StrapiSingleResponse<EquipoPage>>(
    '/api/equipo-page?populate[header]=true&populate[filosofia]=true'
  );
  return res?.data ?? null;
}

export async function getInsightsPage(): Promise<InsightsPage | null> {
  const res = await request<StrapiSingleResponse<InsightsPage>>('/api/insights-page?populate[header]=true');
  return res?.data ?? null;
}

export async function getContactoPage(): Promise<ContactoPage | null> {
  const res = await request<StrapiSingleResponse<ContactoPage>>('/api/contacto-page?populate[header]=true');
  return res?.data ?? null;
}

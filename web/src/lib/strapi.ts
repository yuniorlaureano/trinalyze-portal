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

export interface AboutPage {
  queHacemosHeading: string;
  queHacemosBody: string;
  hqCity: string;
  activeBusinessLines: number;
  filosofiaHeading: string | null;
  filosofiaBody: string | null;
}

export interface ProcessPhase {
  id: number;
  numeral: string;
  title: string;
  question: string;
  detail: string;
}

export interface ProcessPage {
  heading: string;
  intro: string | null;
  phases: ProcessPhase[];
}

function sortByOrder<T extends { order: number }>(items: T[]): T[] {
  return [...items].sort((a, b) => a.order - b.order);
}

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

export async function getAboutPage(): Promise<AboutPage | null> {
  const res = await request<StrapiSingleResponse<AboutPage>>('/api/about-page');
  return res?.data ?? null;
}

export async function getProcessPage(): Promise<ProcessPage | null> {
  const res = await request<StrapiSingleResponse<ProcessPage>>('/api/process-page?populate=*');
  return res?.data ?? null;
}

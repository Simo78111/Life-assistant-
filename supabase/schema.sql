-- My Life Assistant: database setup for member accounts (next step)
-- Run once in Supabase: SQL Editor -> New query -> paste -> Run.
-- Each member signs in, and can only ever see their own reflections, photos and celebrations.

create table if not exists public.profiles (
  id uuid primary key references auth.users on delete cascade,
  created_at timestamptz not null default now(),
  name text not null,
  email text,
  tier text not null default 'try_me' check (tier in ('try_me', 'lifestyle', 'elite', 'luxury')),
  focus text[] not null default '{}',
  groups text[] not null default '{}',
  experiences text[] not null default '{}'
);

create table if not exists public.reflections (
  user_id uuid not null references auth.users on delete cascade,
  month text not null check (month ~ '^\d{4}-\d{2}$'),        -- e.g. 2026-10
  answers jsonb not null default '{}'::jsonb,                  -- the 7 monthly prompts
  updated_at timestamptz not null default now(),
  primary key (user_id, month)
);

create table if not exists public.photos (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users on delete cascade,
  month text not null check (month ~ '^\d{4}-\d{2}$'),
  storage_path text not null,                                  -- file in the "photos" storage bucket
  created_at timestamptz not null default now()
);

create table if not exists public.celebrations (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users on delete cascade,
  who text not null,
  occasion text not null,
  date date not null,
  gift_budget numeric
);

-- Security: every row belongs to one member, and only that member can read or change it.
alter table public.profiles enable row level security;
alter table public.reflections enable row level security;
alter table public.photos enable row level security;
alter table public.celebrations enable row level security;

drop policy if exists "Own profile" on public.profiles;
create policy "Own profile" on public.profiles for all to authenticated
  using (id = auth.uid()) with check (id = auth.uid());

drop policy if exists "Own reflections" on public.reflections;
create policy "Own reflections" on public.reflections for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists "Own photos" on public.photos;
create policy "Own photos" on public.photos for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists "Own celebrations" on public.celebrations;
create policy "Own celebrations" on public.celebrations for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

-- Private photo storage: files live under a folder named after the member's id.
insert into storage.buckets (id, name, public) values ('photos', 'photos', false)
  on conflict (id) do nothing;

drop policy if exists "Own photo files" on storage.objects;
create policy "Own photo files" on storage.objects for all to authenticated
  using (bucket_id = 'photos' and (storage.foldername(name))[1] = auth.uid()::text)
  with check (bucket_id = 'photos' and (storage.foldername(name))[1] = auth.uid()::text);

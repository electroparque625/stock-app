-- Tablas para el módulo "Importados": una copia de solo-lectura de las dos
-- hojas de Google Sheets (costos de artículo y lote de pendientes) que
-- alimenta el bot de Importaciones. Se sincronizan periódicamente desde
-- afuera del sistema (no las edita nadie a mano acá).
--
-- Cómo correrlo: Supabase → tu proyecto → SQL Editor → pegar y ejecutar (Run).

create table if not exists public.importados_catalogo (
  fila int primary key,
  titulo text,
  marca text,
  modelo text,
  categoria text,
  origen text,
  precio_dolares numeric,
  precio_pesos numeric,
  venta numeric,
  beneficio numeric,
  cantidad int,
  en_camino int,
  estado text,
  ubicacion text,
  qr_link text,
  updated_at timestamptz not null default now()
);

create table if not exists public.importados_lotes (
  fila int primary key,
  guia text,
  producto text,
  cantidad int,
  unit_price numeric,
  amount numeric,
  precio_invoice numeric,
  fecha text,
  estado text,
  updated_at timestamptz not null default now()
);

alter table public.importados_catalogo enable row level security;
alter table public.importados_lotes enable row level security;

-- Mismo criterio de acceso que el resto del sistema (confía en la clave
-- anónima, no en Supabase Auth): lectura y escritura abiertas para poder
-- sincronizar y mostrar los datos.
drop policy if exists "importados_catalogo_all" on public.importados_catalogo;
create policy "importados_catalogo_all" on public.importados_catalogo for all using (true) with check (true);

drop policy if exists "importados_lotes_all" on public.importados_lotes;
create policy "importados_lotes_all" on public.importados_lotes for all using (true) with check (true);

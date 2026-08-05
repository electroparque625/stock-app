-- Registro de pagos de clientes, para poder armar las cuentas corrientes
-- (cuánto se llevó cada cliente en total vs. cuánto pagó vs. cuánto debe).
--
-- Cómo correrlo: Supabase → tu proyecto → SQL Editor → pegar y ejecutar (Run).

create table if not exists public.pagos (
  id bigint generated always as identity primary key,
  cliente_nombre text not null,
  cliente_telefono text,
  monto numeric not null,
  fecha timestamptz not null default now(),
  observaciones text,
  creado_por text,
  created_at timestamptz not null default now()
);

alter table public.pagos enable row level security;
drop policy if exists "pagos_all" on public.pagos;
create policy "pagos_all" on public.pagos for all using (true) with check (true);

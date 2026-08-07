create table if not exists public.facturacion_mensual (
  id bigint generated always as identity primary key,
  mes text not null unique, -- formato 'YYYY-MM'
  ml_bruto numeric not null default 0,
  ml_deducciones numeric not null default 0,
  ml_neto numeric not null default 0,
  ml_ventas int not null default 0,
  otros_monto numeric not null default 0,
  otros_ventas int not null default 0,
  otros_unidades int not null default 0,
  reparaciones_monto numeric not null default 0,
  reparaciones_cnt int not null default 0,
  total numeric not null default 0,
  updated_at timestamptz not null default now()
);

alter table public.facturacion_mensual enable row level security;
drop policy if exists "facturacion_mensual_all" on public.facturacion_mensual;
create policy "facturacion_mensual_all" on public.facturacion_mensual for all using (true) with check (true);

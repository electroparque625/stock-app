alter table public.facturacion_mensual add column if not exists ml_por_cuenta jsonb not null default '{}'::jsonb;
alter table public.facturacion_mensual add column if not exists canales_detalle jsonb not null default '{}'::jsonb;

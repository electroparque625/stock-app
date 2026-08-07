alter table public.facturacion_mensual add column if not exists presupuestos_monto numeric not null default 0;
alter table public.facturacion_mensual add column if not exists presupuestos_cnt int not null default 0;

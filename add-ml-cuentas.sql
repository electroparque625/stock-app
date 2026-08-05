-- Cuentas de MercadoLibre, ahora administrables desde el sistema en vez de
-- estar fijas en el código. "numero" es el que usan los logs de venta
-- automáticos (texto "Venta Cuenta N"); "id" es el que usa la carga manual
-- de reportes (el <select> al subir el Excel).
--
-- Cómo correrlo: Supabase → tu proyecto → SQL Editor → pegar y ejecutar (Run).

create table if not exists public.ml_cuentas (
  id text primary key,
  numero int not null unique,
  nombre text not null,
  color text not null default '#3498db',
  orden int not null default 0
);

alter table public.ml_cuentas enable row level security;
drop policy if exists "ml_cuentas_all" on public.ml_cuentas;
create policy "ml_cuentas_all" on public.ml_cuentas for all using (true) with check (true);

-- Se cargan Ivan y Gustavo con los mismos números que ya usaban (se deja
-- fuera Mauro a propósito, según lo pedido).
insert into public.ml_cuentas (id, numero, nombre, color, orden) values
  ('ivan', 1, 'Ivan', '#3498db', 1),
  ('gustavo', 2, 'Gustavo', '#e67e22', 2)
on conflict (id) do nothing;

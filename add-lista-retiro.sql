-- Lista de retiro: anotás el MLA/código de una venta y el sistema busca solo a qué
-- producto y a qué cuenta de Mercado Libre pertenece (según en qué de los 3 casilleros
-- ML ID del producto aparece ese código), agrupando todo por cuenta para ir una sola vez
-- a buscar todos los pedidos de esa cuenta en vez de uno por uno.
create table if not exists public.lista_retiro (
  id bigint generated always as identity primary key,
  mla text,
  articulo text,
  sku text,
  cantidad integer not null default 1,
  stock_id integer,
  cuenta_numero text,
  cuenta_nombre text,
  retirado boolean not null default false,
  usuario text,
  created_at timestamptz not null default now()
);

alter table public.lista_retiro enable row level security;
create policy "lista_retiro_all" on public.lista_retiro for all using (true) with check (true);

-- Vincula cada producto del catálogo de Importados con su producto real
-- en el inventario de stock-app, y lleva la cuenta de cuánta cantidad ya
-- se sumó al inventario (para no volver a sumarla en cada sincronización).
--
-- Cómo correrlo: Supabase → tu proyecto → SQL Editor → pegar y ejecutar (Run).

alter table public.importados_catalogo
  add column if not exists stock_app_id int references public.stock(id);

alter table public.importados_catalogo
  add column if not exists cantidad_aplicada int not null default 0;

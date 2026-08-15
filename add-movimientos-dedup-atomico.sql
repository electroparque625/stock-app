-- Evita a nivel base de datos que una misma venta de Mercado Libre (mismo pedido +
-- mismo producto) se cargue dos veces si dos pestañas/corridas del sync la procesan
-- casi al mismo instante. Antes esto se controlaba solo desde el código (consultar
-- "¿ya existe?" y después insertar) — eso tiene una ventana de milisegundos donde dos
-- corridas pueden consultar antes de que cualquiera termine de guardar, y las dos
-- insertan. La base de datos, a diferencia del código, puede rechazar el duplicado de
-- forma atómica.
alter table public.movimientos add column if not exists orden_ml text;
alter table public.movimientos add column if not exists mla_ml text;
create unique index if not exists movimientos_ml_dedup on public.movimientos (orden_ml, mla_ml) where orden_ml is not null;

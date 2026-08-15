-- Suma a Lista de retiro: número de pedido (para agrupar productos del mismo pedido),
-- observaciones del producto y su ubicación (caja/estantería), así el que va a buscar
-- todo sabe exactamente qué es, dónde está, y cuántos productos van juntos por pedido.
alter table public.lista_retiro add column if not exists orden text;
alter table public.lista_retiro add column if not exists observaciones text;
alter table public.lista_retiro add column if not exists ubicacion text;

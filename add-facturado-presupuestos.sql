-- Agrega el estado de facturación a los presupuestos, para que el sistema
-- sepa si ya se descontó el stock de un presupuesto (al facturarlo) y no
-- lo descuente de nuevo si se reimprime la factura.
--
-- Cómo correrlo: Supabase → tu proyecto → SQL Editor → pegar y ejecutar (Run).

alter table public.presupuestos
  add column if not exists facturado boolean not null default false;

alter table public.presupuestos
  add column if not exists fecha_facturacion timestamptz;

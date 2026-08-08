alter table public.stock add column if not exists web_product_id uuid;
alter table public.stock add column if not exists web_publicado_at timestamptz;

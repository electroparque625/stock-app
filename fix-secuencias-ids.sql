-- Arregla el "numerador" interno de IDs de todas las tablas de la base.
-- Quedó desincronizado en algún momento (probablemente por una importación vieja
-- que cargó filas con ID puesto a mano), y eso hace que al crear una fila nueva
-- la base intente reusar un ID que ya existe (error "duplicate key").
-- Este script no borra ni cambia ningún dato: solo pone el numerador de cada
-- tabla en el ID más alto que ya existe, para que el próximo sea siempre nuevo.
DO $$
DECLARE
  r RECORD;
BEGIN
  FOR r IN
    SELECT c.relname AS table_name, a.attname AS column_name,
           pg_get_serial_sequence(c.relname, a.attname) AS seq
    FROM pg_class c
    JOIN pg_attribute a ON a.attrelid = c.oid
    WHERE c.relkind = 'r' AND c.relnamespace = 'public'::regnamespace
      AND pg_get_serial_sequence(c.relname, a.attname) IS NOT NULL
  LOOP
    EXECUTE format('SELECT setval(%L, COALESCE((SELECT MAX(%I) FROM %I), 1))', r.seq, r.column_name, r.table_name);
  END LOOP;
END $$;

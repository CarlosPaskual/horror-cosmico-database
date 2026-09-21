--
-- Esquema base y extensiones requeridas
--
-- Este proyecto usa dos extensiones de PostgreSQL provistas por Supabase:
--   - uuid-ossp   (esquema "extensions") -> genera los UUID de las claves primarias
--   - pg_trgm                            -> búsqueda difusa por texto (índices GIN trigram)
--
-- En Supabase se activan desde el dashboard: Database -> Extensions
-- (no requieren CREATE EXTENSION manual si el proyecto ya las tiene habilitadas)
--

CREATE SCHEMA public;

COMMENT ON SCHEMA public IS 'standard public schema';

SET default_tablespace = '';
SET default_table_access_method = heap;

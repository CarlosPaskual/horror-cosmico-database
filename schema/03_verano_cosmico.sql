--
-- VERANO CÓSMICO
-- Formato de temporada de verano, con sus propias obras y personas citadas.
--

CREATE TABLE public.verano_cosmico (
    numero text NOT NULL,
    titulo text NOT NULL,
    descripcion text,
    fecha_publicacion date,
    duracion_segundos integer,
    audio_url text,
    cover_image_url text,
    audio_url_spotify text
);

CREATE TABLE public.verano_cosmico_obras (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    numero text NOT NULL,
    tipo text,
    titulo text NOT NULL,
    director text,
    year integer,
    external_url text
);

CREATE TABLE public.verano_cosmico_personas (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    numero text NOT NULL,
    persona text NOT NULL,
    rol text,
    notas text
);

CREATE VIEW public.verano_cosmico_full AS
 SELECT numero,
    titulo,
    descripcion,
    fecha_publicacion,
    duracion_segundos,
    audio_url,
    audio_url_spotify,
    cover_image_url,
    COALESCE(( SELECT json_agg(json_build_object('persona', p.persona, 'rol', p.rol, 'notas', p.notas)) AS json_agg
           FROM public.verano_cosmico_personas p
          WHERE (p.numero = v.numero)), '[]'::json) AS participants,
    COALESCE(( SELECT json_agg(json_build_object('tipo', o.tipo, 'titulo', o.titulo, 'director', o.director, 'year', o.year, 'url', o.external_url)) AS json_agg
           FROM public.verano_cosmico_obras o
          WHERE (o.numero = v.numero)), '[]'::json) AS obras
   FROM public.verano_cosmico v
  ORDER BY numero;

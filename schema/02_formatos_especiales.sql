--
-- FORMATOS ESPECIALES
-- Contenidos del podcast que no siguen la numeración estándar de
-- temporada/episodio: Especiales, Microreseñas y "SPTT".
--

CREATE TABLE public.especiales (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    titulo text NOT NULL,
    descripcion text,
    fecha_publicacion date,
    duracion_segundos integer,
    audio_url text,
    notas text,
    audio_url_spotify text
);

CREATE VIEW public.especiales_full AS
 SELECT id,
    titulo,
    descripcion,
    fecha_publicacion,
    duracion_segundos,
    audio_url,
    audio_url_spotify,
    notas
   FROM public.especiales
  ORDER BY fecha_publicacion;

CREATE TABLE public.microresenas (
    numero integer NOT NULL,
    titulo text NOT NULL,
    descripcion text,
    fecha_publicacion date,
    duracion_segundos integer,
    audio_url text,
    obra_titulo text,
    obra_tipo text,
    obra_autor text,
    audio_url_spotify text
);

CREATE VIEW public.microresenas_full AS
 SELECT numero,
    titulo,
    descripcion,
    fecha_publicacion,
    duracion_segundos,
    audio_url,
    audio_url_spotify,
    obra_titulo,
    obra_tipo,
    obra_autor
   FROM public.microresenas
  ORDER BY numero;

CREATE TABLE public.sptt_episodes (
    numero text NOT NULL,
    titulo text NOT NULL,
    descripcion text,
    fecha_publicacion date,
    duracion_segundos integer,
    audio_url text,
    acceso text,
    obra_titulo text,
    obra_tipo text,
    obra_autor text,
    audio_url_spotify text
);

CREATE TABLE public.sptt_personas (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    numero text NOT NULL,
    persona text NOT NULL,
    rol text,
    notas text
);

CREATE VIEW public.sptt_full AS
 SELECT numero,
    titulo,
    descripcion,
    fecha_publicacion,
    duracion_segundos,
    audio_url,
    audio_url_spotify,
    acceso,
    obra_titulo,
    obra_tipo,
    obra_autor,
    COALESCE(( SELECT json_agg(json_build_object('persona', p.persona, 'rol', p.rol, 'notas', p.notas)) AS json_agg
           FROM public.sptt_personas p
          WHERE (p.numero = s.numero)), '[]'::json) AS participants
   FROM public.sptt_episodes s
  ORDER BY numero;

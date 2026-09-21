--
-- BÚSQUEDA UNIFICADA
-- Une los 5 formatos de contenido (episodios, SPTT, Verano Cósmico,
-- microreseñas, especiales) en una sola vista con columnas homogéneas,
-- para que el buscador del front-end consulte una única fuente.
--

CREATE VIEW public.unified_search AS
 SELECT 'episodio'::text AS source_type,
    (e.id)::text AS id,
    (((e.season_number)::text || 'x'::text) || (e.episode_number)::text) AS numero,
    e.title AS titulo,
    e.description AS descripcion,
    e.publish_date AS fecha_publicacion,
    e.duration_seconds AS duracion_segundos,
    e.cover_image_url,
    e.audio_url,
    e.audio_url_spotify,
    e.is_special
   FROM public.episodes e
UNION ALL
 SELECT 'sptt'::text AS source_type,
    sptt_episodes.numero AS id,
    sptt_episodes.numero,
    sptt_episodes.titulo,
    sptt_episodes.descripcion,
    sptt_episodes.fecha_publicacion,
    sptt_episodes.duracion_segundos,
    NULL::text AS cover_image_url,
    sptt_episodes.audio_url,
    sptt_episodes.audio_url_spotify,
    false AS is_special
   FROM public.sptt_episodes
UNION ALL
 SELECT 'verano_cosmico'::text AS source_type,
    verano_cosmico.numero AS id,
    verano_cosmico.numero,
    verano_cosmico.titulo,
    verano_cosmico.descripcion,
    verano_cosmico.fecha_publicacion,
    verano_cosmico.duracion_segundos,
    verano_cosmico.cover_image_url,
    verano_cosmico.audio_url,
    verano_cosmico.audio_url_spotify,
    false AS is_special
   FROM public.verano_cosmico
UNION ALL
 SELECT 'microresena'::text AS source_type,
    (microresenas.numero)::text AS id,
    (microresenas.numero)::text AS numero,
    microresenas.titulo,
    microresenas.descripcion,
    microresenas.fecha_publicacion,
    microresenas.duracion_segundos,
    NULL::text AS cover_image_url,
    microresenas.audio_url,
    microresenas.audio_url_spotify,
    false AS is_special
   FROM public.microresenas
UNION ALL
 SELECT 'especial'::text AS source_type,
    (especiales.id)::text AS id,
    NULL::text AS numero,
    especiales.titulo,
    especiales.descripcion,
    especiales.fecha_publicacion,
    especiales.duracion_segundos,
    NULL::text AS cover_image_url,
    especiales.audio_url,
    especiales.audio_url_spotify,
    true AS is_special
   FROM public.especiales;

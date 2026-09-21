--
-- NÚCLEO DEL PODCAST
-- Temporadas, episodios principales y las entidades que se les relacionan:
-- personas, temas, secciones, obras citadas y videojuegos citados.
--

CREATE TABLE public.seasons (
    season_number integer NOT NULL,
    title text,
    start_date date,
    end_date date
);

CREATE TABLE public.episodes (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    episode_number integer NOT NULL,
    season_number integer NOT NULL,
    title text NOT NULL,
    description text,
    publish_date date,
    duration_seconds integer,
    audio_url text,
    audio_url_spotify text,
    cover_image_url text,
    is_special boolean DEFAULT false NOT NULL,
    CONSTRAINT episodes_duration_seconds_check CHECK ((duration_seconds > 0))
);

CREATE TABLE public.people (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    bio text,
    is_host boolean DEFAULT false NOT NULL,
    twitter text,
    instagram text
);

CREATE TABLE public.sections (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    description text
);

CREATE TABLE public.topics (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    category text,
    description text
);

-- Tablas puente (relaciones muchos-a-muchos)

CREATE TABLE public.episode_people (
    episode_id uuid NOT NULL,
    person_id uuid NOT NULL,
    role text NOT NULL,
    notes text
);

CREATE TABLE public.episode_sections (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    episode_id uuid NOT NULL,
    section_id uuid NOT NULL,
    notes text,
    timestamp_seconds integer
);

CREATE TABLE public.episode_topics (
    episode_id uuid NOT NULL,
    topic_id uuid NOT NULL
);

-- Referencias citadas dentro de un episodio

CREATE TABLE public.works_cited (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    episode_id uuid NOT NULL,
    type text NOT NULL,
    title text NOT NULL,
    author_or_creator text,
    year integer,
    external_url text
);

CREATE TABLE public.videogames_cited (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    episode_id uuid NOT NULL,
    title text NOT NULL,
    year integer,
    editor text,
    genre text,
    platforms text,
    synopsis text,
    external_url text
);

--
-- Vista agregada: cada episodio con sus participantes, temas, secciones
-- y referencias ya "aplanados" en JSON, lista para consumir desde el front-end
-- sin necesidad de hacer varios JOIN en el cliente.
--

CREATE VIEW public.episodes_full AS
 SELECT id,
    episode_number,
    season_number,
    title,
    description,
    publish_date,
    duration_seconds,
    audio_url,
    audio_url_spotify,
    cover_image_url,
    is_special,
    COALESCE(( SELECT json_agg(json_build_object('name', p.name, 'role', ep.role, 'notes', ep.notes)) AS json_agg
           FROM (public.episode_people ep
             JOIN public.people p ON ((p.id = ep.person_id)))
          WHERE (ep.episode_id = e.id)), '[]'::json) AS participants,
    COALESCE(( SELECT json_agg(t.name) AS json_agg
           FROM (public.episode_topics et
             JOIN public.topics t ON ((t.id = et.topic_id)))
          WHERE (et.episode_id = e.id)), '[]'::json) AS topics,
    COALESCE(( SELECT json_agg(json_build_object('name', s.name, 'notes', es.notes, 'timestamp_seconds', es.timestamp_seconds)) AS json_agg
           FROM (public.episode_sections es
             JOIN public.sections s ON ((s.id = es.section_id)))
          WHERE (es.episode_id = e.id)), '[]'::json) AS sections,
    COALESCE(( SELECT json_agg(json_build_object('type', w.type, 'title', w.title, 'author', w.author_or_creator, 'year', w.year, 'url', w.external_url)) AS json_agg
           FROM public.works_cited w
          WHERE (w.episode_id = e.id)), '[]'::json) AS works_cited,
    COALESCE(( SELECT json_agg(json_build_object('title', v.title, 'year', v.year, 'editor', v.editor, 'genre', v.genre, 'platforms', v.platforms, 'synopsis', v.synopsis, 'url', v.external_url)) AS json_agg
           FROM public.videogames_cited v
          WHERE (v.episode_id = e.id)), '[]'::json) AS videogames
   FROM public.episodes e
  ORDER BY season_number, episode_number;

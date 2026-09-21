--
-- ROW LEVEL SECURITY
-- Todas las tablas tienen RLS activado con una única política de
-- lectura pública (SELECT abierto a cualquiera). No hay escritura
-- pública: las inserciones/actualizaciones se hacen desde el backend
-- con la service role key, nunca desde el cliente.
--

CREATE POLICY "Lectura pública" ON public.episode_people FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.episode_sections FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.episode_topics FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.episodes FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.especiales FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.microresenas FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.people FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.seasons FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.sections FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.sptt_episodes FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.sptt_personas FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.topics FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.verano_cosmico FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.verano_cosmico_obras FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.verano_cosmico_personas FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.videogames_cited FOR SELECT USING (true);
CREATE POLICY "Lectura pública" ON public.works_cited FOR SELECT USING (true);

ALTER TABLE public.episode_people ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.episode_sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.episode_topics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.episodes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.especiales ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.microresenas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.people ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.seasons ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sptt_episodes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sptt_personas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.topics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.verano_cosmico ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.verano_cosmico_obras ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.verano_cosmico_personas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.videogames_cited ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.works_cited ENABLE ROW LEVEL SECURITY;

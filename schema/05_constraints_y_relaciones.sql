--
-- CLAVES PRIMARIAS Y RESTRICCIONES ÚNICAS
--

ALTER TABLE ONLY public.episode_people
    ADD CONSTRAINT episode_people_pkey PRIMARY KEY (episode_id, person_id, role);

ALTER TABLE ONLY public.episode_sections
    ADD CONSTRAINT episode_sections_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.episode_topics
    ADD CONSTRAINT episode_topics_pkey PRIMARY KEY (episode_id, topic_id);

ALTER TABLE ONLY public.episodes
    ADD CONSTRAINT episodes_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.episodes
    ADD CONSTRAINT episodes_season_number_episode_number_key UNIQUE (season_number, episode_number);

ALTER TABLE ONLY public.especiales
    ADD CONSTRAINT especiales_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.microresenas
    ADD CONSTRAINT microresenas_pkey PRIMARY KEY (numero);

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_name_key UNIQUE (name);

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_pkey PRIMARY KEY (season_number);

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_name_key UNIQUE (name);

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.sptt_episodes
    ADD CONSTRAINT sptt_episodes_pkey PRIMARY KEY (numero);

ALTER TABLE ONLY public.sptt_personas
    ADD CONSTRAINT sptt_personas_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_name_key UNIQUE (name);

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.verano_cosmico_obras
    ADD CONSTRAINT verano_cosmico_obras_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.verano_cosmico_personas
    ADD CONSTRAINT verano_cosmico_personas_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.verano_cosmico
    ADD CONSTRAINT verano_cosmico_pkey PRIMARY KEY (numero);

ALTER TABLE ONLY public.videogames_cited
    ADD CONSTRAINT videogames_cited_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.works_cited
    ADD CONSTRAINT works_cited_pkey PRIMARY KEY (id);

--
-- ÍNDICES DE RENDIMIENTO
-- btree para joins frecuentes por FK, GIN + pg_trgm para búsqueda
-- difusa de texto (autocompletado / búsqueda parcial sin acentos exactos).
--

CREATE INDEX idx_episode_people_person ON public.episode_people USING btree (person_id);

CREATE INDEX idx_episode_sections_episode ON public.episode_sections USING btree (episode_id);

CREATE INDEX idx_episode_sections_section ON public.episode_sections USING btree (section_id);

CREATE INDEX idx_episode_topics_topic ON public.episode_topics USING btree (topic_id);

CREATE INDEX idx_episodes_publish_date ON public.episodes USING btree (publish_date DESC);

CREATE INDEX idx_episodes_title_trgm ON public.episodes USING gin (title public.gin_trgm_ops);

CREATE INDEX idx_people_name_trgm ON public.people USING gin (name public.gin_trgm_ops);

CREATE INDEX idx_sptt_personas_numero ON public.sptt_personas USING btree (numero);

CREATE INDEX idx_topics_name_trgm ON public.topics USING gin (name public.gin_trgm_ops);

CREATE INDEX idx_verano_obras_numero ON public.verano_cosmico_obras USING btree (numero);

CREATE INDEX idx_verano_personas_numero ON public.verano_cosmico_personas USING btree (numero);

CREATE INDEX idx_videogames_cited_episode ON public.videogames_cited USING btree (episode_id);

CREATE INDEX idx_works_cited_episode ON public.works_cited USING btree (episode_id);

CREATE INDEX idx_works_cited_title_trgm ON public.works_cited USING gin (title public.gin_trgm_ops);

--
-- CLAVES FORÁNEAS
--

ALTER TABLE ONLY public.episode_people
    ADD CONSTRAINT episode_people_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.episodes(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.episode_people
    ADD CONSTRAINT episode_people_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.people(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.episode_sections
    ADD CONSTRAINT episode_sections_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.episodes(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.episode_sections
    ADD CONSTRAINT episode_sections_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.episode_topics
    ADD CONSTRAINT episode_topics_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.episodes(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.episode_topics
    ADD CONSTRAINT episode_topics_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.episodes
    ADD CONSTRAINT episodes_season_number_fkey FOREIGN KEY (season_number) REFERENCES public.seasons(season_number) ON DELETE RESTRICT;

ALTER TABLE ONLY public.sptt_personas
    ADD CONSTRAINT sptt_personas_numero_fkey FOREIGN KEY (numero) REFERENCES public.sptt_episodes(numero) ON DELETE CASCADE;

ALTER TABLE ONLY public.verano_cosmico_obras
    ADD CONSTRAINT verano_cosmico_obras_numero_fkey FOREIGN KEY (numero) REFERENCES public.verano_cosmico(numero) ON DELETE CASCADE;

ALTER TABLE ONLY public.verano_cosmico_personas
    ADD CONSTRAINT verano_cosmico_personas_numero_fkey FOREIGN KEY (numero) REFERENCES public.verano_cosmico(numero) ON DELETE CASCADE;

ALTER TABLE ONLY public.videogames_cited
    ADD CONSTRAINT videogames_cited_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.episodes(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.works_cited
    ADD CONSTRAINT works_cited_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.episodes(id) ON DELETE CASCADE;

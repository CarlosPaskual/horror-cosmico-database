# El horror có(s)mico — Base de datos

Esquema relacional en PostgreSQL (Supabase) para el podcast de terror **El horror có(s)mico**: 17 tablas que modelan episodios, formatos especiales y sus relaciones, con búsqueda unificada y Row Level Security.

## Proyecto relacionado

Este esquema es consumido en vivo por [`horror-cosmico-app`](https://github.com/CarlosPaskual/horror-cosmico-app), la interfaz de búsqueda visual del podcast.

## Diseño

El dominio se organiza en cuatro bloques:

- **Núcleo del podcast** — `episodes`, `seasons`, `people`, `topics`, `sections`, más las tablas puente que relacionan episodios con personas, temas y secciones, y las referencias citadas (`works_cited`, `videogames_cited`)
- **Formatos especiales** — `especiales`, `microresenas`, `sptt_episodes` y `sptt_personas`, para contenidos que no siguen la numeración estándar de temporada/episodio
- **Verano Cósmico** — `verano_cosmico`, `verano_cosmico_obras`, `verano_cosmico_personas`, un formato de temporada de verano con sus propias obras y personas citadas
- **Búsqueda unificada** — una vista (`unified_search`) que combina los cinco formatos de contenido en una sola tabla lógica, para que el front-end consulte una única fuente

Cada bloque incluye vistas `*_full` que agregan sus relaciones como JSON (participantes, temas, obras citadas...), evitando que el cliente tenga que resolver varios `JOIN` por su cuenta.

## Seguridad

Row Level Security activado en las 17 tablas, con una única política de lectura pública (`SELECT` abierto). No hay escritura pública: las inserciones y actualizaciones se hacen desde el backend con la *service role key*, nunca desde el cliente.

## Estructura del repo

```
schema/
├── 00_extensiones_y_schema.sql      # Esquema base y extensiones (uuid-ossp, pg_trgm)
├── 01_nucleo_podcast.sql            # Episodios, temporadas, personas, temas, secciones
├── 02_formatos_especiales.sql       # Especiales, Microreseñas, SPTT
├── 03_verano_cosmico.sql            # Formato Verano Cósmico
├── 04_busqueda_unificada.sql        # Vista unified_search
├── 05_constraints_y_relaciones.sql  # Primary keys, foreign keys, índices
└── 06_seguridad_rls.sql             # Políticas de Row Level Security
```

Los archivos están numerados en el orden en que deben ejecutarse (respetan las dependencias por clave foránea).

## Stack

PostgreSQL 17 (Supabase), extensión `pg_trgm` para búsqueda difusa de texto.

## Qué aprendí

Diseñar un esquema que soporta cinco formatos de contenido con estructuras distintas (algunos usan `uuid`, otros usan `numero` de texto como clave) sin duplicar lógica, resolviéndolo con una vista de unión (`unified_search`) en vez de forzar todos los formatos a una tabla única. También trabajar con vistas que devuelven JSON agregado directamente desde SQL, para simplificar el consumo desde el front-end.

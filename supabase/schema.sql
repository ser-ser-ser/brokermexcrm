-- BROKERMEX V2 - SCHEMA.SQL (Profesional)
-- Extensiones necesarias
create extension if not exists "pgcrypto";
create extension if not exists "uuid-ossp";

-- TABLAS ----------------------------------------------------

-- Perfiles
CREATE TABLE public.perfiles (
  id uuid NOT NULL,
  nombre_completo text NOT NULL,
  email text,
  rol text NOT NULL CHECK (rol = ANY (ARRAY['superadmin','admin','admin2','broker'])),
  telefono text,
  avatar_url text,
  identificador_broker text,
  creado_en timestamp DEFAULT now(),
  CONSTRAINT perfiles_pkey PRIMARY KEY (id),
  CONSTRAINT perfiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id)
);

-- Clientes
CREATE TABLE public.clientes (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  nombre_completo text NOT NULL,
  email text,
  telefono text,
  creado_en timestamp DEFAULT now(),
  creado_por uuid,
  CONSTRAINT clientes_pkey PRIMARY KEY (id),
  CONSTRAINT clientes_creado_por_fkey FOREIGN KEY (creado_por) REFERENCES public.perfiles(id)
);

-- Propiedades
CREATE TABLE public.propiedades (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  tipo text NOT NULL CHECK (tipo = ANY (ARRAY['industrial','comercial','residencial','desarrollo'])),
  subtipo text NOT NULL,
  titulo text NOT NULL,
  descripcion text,
  direccion text,
  ciudad text,
  estado text,
  codigo_postal text,
  latitud numeric,
  longitud numeric,
  ubicacion_maps_url text,
  precio_mxn numeric,
  precio_usd numeric,
  moneda_predeterminada text DEFAULT 'mxn',
  superficie_construida numeric,
  superficie_total numeric,
  altura numeric,
  oficinas numeric,
  banos numeric,
  cajones_estacionamiento int,
  en_parque_industrial boolean DEFAULT false,
  en_fraccionamiento boolean DEFAULT false,
  propietario_id uuid,
  registrado_por uuid,
  compartida boolean DEFAULT false,
  co_gestores uuid[],
  etiquetas text[],
  estatus_publicacion text DEFAULT 'borrador',
  creado_en timestamp DEFAULT now(),
  actualizado_en timestamp DEFAULT now(),
  CONSTRAINT propiedades_pkey PRIMARY KEY (id),
  CONSTRAINT propiedades_propietario_id_fkey FOREIGN KEY (propietario_id) REFERENCES public.clientes(id),
  CONSTRAINT propiedades_registrado_por_fkey FOREIGN KEY (registrado_por) REFERENCES public.perfiles(id)
);

-- Pipeline
CREATE TABLE public.pipeline (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  propiedad_id uuid,
  oportunidad_id uuid,
  cliente_id uuid,
  estado text NOT NULL,
  columna text NOT NULL,
  posicion numeric DEFAULT 0,
  asignado_a uuid,
  progreso_percent int DEFAULT 0,
  prioridad text,
  etiquetas text[],
  notas text,
  creado_en timestamp DEFAULT now(),
  actualizado_en timestamp DEFAULT now(),
  CONSTRAINT pipeline_pkey PRIMARY KEY (id),
  CONSTRAINT pipeline_propiedad_id_fkey FOREIGN KEY (propiedad_id) REFERENCES public.propiedades(id),
  CONSTRAINT pipeline_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id)
);

-- Oportunidades
CREATE TABLE public.oportunidades (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  cliente_id uuid,
  propiedad_id uuid,
  origen text,
  valor_estimado numeric,
  estado text DEFAULT 'nuevo',
  asignado_a uuid,
  notas text,
  metadata jsonb DEFAULT '{}'::jsonb,
  created_at timestamp DEFAULT now(),
  updated_at timestamp DEFAULT now(),
  CONSTRAINT oportunidades_pkey PRIMARY KEY (id),
  CONSTRAINT oportunidades_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id),
  CONSTRAINT oportunidades_propiedad_id_fkey FOREIGN KEY (propiedad_id) REFERENCES public.propiedades(id),
  CONSTRAINT oportunidades_asignado_a_fkey FOREIGN KEY (asignado_a) REFERENCES public.perfiles(id)
);

-- Notas Oportunidades
CREATE TABLE public.notas_oportunidades (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  oportunidad_id uuid,
  creado_por uuid,
  texto text,
  archivos jsonb DEFAULT '[]'::jsonb,
  created_at timestamp DEFAULT now(),
  CONSTRAINT notas_oportunidades_pkey PRIMARY KEY (id),
  CONSTRAINT notas_oportunidades_oportunidad_id_fkey FOREIGN KEY (oportunidad_id) REFERENCES public.oportunidades(id),
  CONSTRAINT notas_oportunidades_creado_por_fkey FOREIGN KEY (creado_por) REFERENCES public.perfiles(id)
);

-- Seguimientos
CREATE TABLE public.seguimientos (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  usuario_id uuid,
  tipo text,
  referencia_tipo text,
  referencia_id uuid,
  descripcion text,
  fecha_programada timestamp with time zone,
  completado boolean DEFAULT false,
  metadata jsonb DEFAULT '{}'::jsonb,
  created_at timestamp DEFAULT now(),
  updated_at timestamp DEFAULT now(),
  CONSTRAINT seguimientos_pkey PRIMARY KEY (id),
  CONSTRAINT seguimientos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.perfiles(id)
);

-- Multimedia
CREATE TABLE public.multimedia (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  propiedad_id uuid,
  creado_por uuid,
  ruta text,
  tipo text,
  metadata jsonb DEFAULT '{}'::jsonb,
  created_at timestamp DEFAULT now(),
  CONSTRAINT multimedia_pkey PRIMARY KEY (id),
  CONSTRAINT multimedia_propiedad_id_fkey FOREIGN KEY (propiedad_id) REFERENCES public.propiedades(id),
  CONSTRAINT multimedia_creado_por_fkey FOREIGN KEY (creado_por) REFERENCES public.perfiles(id)
);

-- Integraciones
CREATE TABLE public.integraciones (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  profile_id uuid,
  provider text,
  credentials jsonb DEFAULT '{}'::jsonb,
  enabled boolean DEFAULT true,
  created_at timestamp DEFAULT now(),
  updated_at timestamp DEFAULT now(),
  CONSTRAINT integraciones_pkey PRIMARY KEY (id),
  CONSTRAINT integraciones_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.perfiles(id)
);

-- Eventos Calendario
CREATE TABLE public.eventos_calendario (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  profile_id uuid,
  titulo text,
  descripcion text,
  start_time timestamp with time zone,
  end_time timestamp with time zone,
  location text,
  external_id text,
  metadata jsonb DEFAULT '{}'::jsonb,
  created_at timestamp DEFAULT now(),
  updated_at timestamp DEFAULT now(),
  CONSTRAINT eventos_calendario_pkey PRIMARY KEY (id),
  CONSTRAINT eventos_calendario_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.perfiles(id)
);

-- TRANSACCIONES
CREATE TABLE public.transacciones (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  oportunidad_id uuid,
  monto numeric,
  tipo text,
  estado text DEFAULT 'pendiente',
  notas text,
  metadata jsonb DEFAULT '{}'::jsonb,
  created_at timestamp DEFAULT now(),
  updated_at timestamp DEFAULT now(),
  CONSTRAINT transacciones_pkey PRIMARY KEY (id),
  CONSTRAINT transacciones_oportunidad_id_fkey FOREIGN KEY (oportunidad_id) REFERENCES public.oportunidades(id)
);

-- POLICIES (placeholder, agrega las que ya tienes)
-- Aquí puedes insertar tus policies existentes.


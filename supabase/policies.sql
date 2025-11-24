-- BROKERMEX V2 - POLICIES.SQL
-- Row Level Security Policies for all tables

-- Perfiles
ALTER TABLE public.perfiles ENABLE ROW LEVEL SECURITY;
-- Read own profile
CREATE POLICY perfiles_select ON public.perfiles FOR SELECT USING (auth.uid() = id);
-- Insert handled by auth, no insert policy
-- Update own profile
CREATE POLICY perfiles_update ON public.perfiles FOR UPDATE USING (auth.uid() = id);

-- Clientes
ALTER TABLE public.clientes ENABLE ROW LEVEL SECURITY;
CREATE POLICY clientes_select ON public.clientes FOR SELECT USING (auth.uid() = creado_por);
CREATE POLICY clientes_insert ON public.clientes FOR INSERT WITH CHECK (auth.uid() = creado_por);
CREATE POLICY clientes_update ON public.clientes FOR UPDATE USING (auth.uid() = creado_por);

-- Propiedades
ALTER TABLE public.propiedades ENABLE ROW LEVEL SECURITY;
CREATE POLICY propiedades_select ON public.propiedades FOR SELECT USING (auth.uid() = registrado_por OR auth.uid() = ANY(co_gestores));
CREATE POLICY propiedades_insert ON public.propiedades FOR INSERT WITH CHECK (auth.uid() = registrado_por);
CREATE POLICY propiedades_update ON public.propiedades FOR UPDATE USING (auth.uid() = registrado_por OR auth.uid() = ANY(co_gestores));

-- Pipeline
ALTER TABLE public.pipeline ENABLE ROW LEVEL SECURITY;
CREATE POLICY pipeline_select ON public.pipeline FOR SELECT USING (auth.uid() = asignado_a);
CREATE POLICY pipeline_insert ON public.pipeline FOR INSERT WITH CHECK (auth.uid() = asignado_a);
CREATE POLICY pipeline_update ON public.pipeline FOR UPDATE USING (auth.uid() = asignado_a);

-- Oportunidades
ALTER TABLE public.oportunidades ENABLE ROW LEVEL SECURITY;
CREATE POLICY oportunidades_select ON public.oportunidades FOR SELECT USING (auth.uid() = asignado_a);
CREATE POLICY oportunidades_insert ON public.oportunidades FOR INSERT WITH CHECK (auth.uid() = asignado_a);
CREATE POLICY oportunidades_update ON public.oportunidades FOR UPDATE USING (auth.uid() = asignado_a);

-- Notas oportunidades
ALTER TABLE public.notas_oportunidades ENABLE ROW LEVEL SECURITY;
CREATE POLICY notas_select ON public.notas_oportunidades FOR SELECT USING (auth.uid() = creado_por);
CREATE POLICY notas_insert ON public.notas_oportunidades FOR INSERT WITH CHECK (auth.uid() = creado_por);

-- Seguimientos
ALTER TABLE public.seguimientos ENABLE ROW LEVEL SECURITY;
CREATE POLICY seg_select ON public.seguimientos FOR SELECT USING (auth.uid() = usuario_id);
CREATE POLICY seg_insert ON public.seguimientos FOR INSERT WITH CHECK (auth.uid() = usuario_id);
CREATE POLICY seg_update ON public.seguimientos FOR UPDATE USING (auth.uid() = usuario_id);

-- Multimedia
ALTER TABLE public.multimedia ENABLE ROW LEVEL SECURITY;
CREATE POLICY multimedia_select ON public.multimedia FOR SELECT USING (auth.uid() = creado_por);
CREATE POLICY multimedia_insert ON public.multimedia FOR INSERT WITH CHECK (auth.uid() = creado_por);

-- Integraciones
ALTER TABLE public.integraciones ENABLE ROW LEVEL SECURITY;
CREATE POLICY integraciones_select ON public.integraciones FOR SELECT USING (auth.uid() = profile_id);
CREATE POLICY integraciones_insert ON public.integraciones FOR INSERT WITH CHECK (auth.uid() = profile_id);
CREATE POLICY integraciones_update ON public.integraciones FOR UPDATE USING (auth.uid() = profile_id);

-- Eventos calendario
ALTER TABLE public.eventos_calendario ENABLE ROW LEVEL SECURITY;
CREATE POLICY eventos_select ON public.eventos_calendario FOR SELECT USING (auth.uid() = profile_id);
CREATE POLICY eventos_insert ON public.eventos_calendario FOR INSERT WITH CHECK (auth.uid() = profile_id);
CREATE POLICY eventos_update ON public.eventos_calendario FOR UPDATE USING (auth.uid() = profile_id);

-- Transacciones
ALTER TABLE public.transacciones ENABLE ROW LEVEL SECURITY;
CREATE POLICY transacciones_select ON public.transacciones FOR SELECT USING (
  auth.uid() = (SELECT asignado_a FROM oportunidades WHERE oportunidades.id = transacciones.oportunidad_id)
);
CREATE POLICY transacciones_insert ON public.transacciones FOR INSERT WITH CHECK (
  auth.uid() = (SELECT asignado_a FROM oportunidades WHERE oportunidades.id = oportunidad_id)
);

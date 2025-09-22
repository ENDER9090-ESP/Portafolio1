-- Crear extensión para generar UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tabla de Proyectos
CREATE TABLE IF NOT EXISTS public.projects (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    title text NOT NULL,
    description text,
    image_url text,
    live_url text,
    technologies text[],
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Tabla de Certificados
CREATE TABLE IF NOT EXISTS public.certificates (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    title text NOT NULL,
    issuer text NOT NULL,
    date date NOT NULL,
    image_url text,
    credential_url text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Tabla de Herramientas
CREATE TABLE IF NOT EXISTS public.tools (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    name text NOT NULL,
    category text NOT NULL,
    proficiency integer CHECK (proficiency >= 0 AND proficiency <= 100),
    icon text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Tabla de Cursos
CREATE TABLE IF NOT EXISTS public.courses (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    title text NOT NULL,
    institution text NOT NULL,
    status text CHECK (status IN ('completed', 'in_progress', 'planned')),
    start_date date NOT NULL,
    end_date date,
    description text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Habilitar Row Level Security
ALTER TABLE public.projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.certificates ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tools ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;

-- Políticas de Seguridad para Lectura Pública
CREATE POLICY "Allow public read access" ON public.projects FOR SELECT USING (true);
CREATE POLICY "Allow public read access" ON public.certificates FOR SELECT USING (true);
CREATE POLICY "Allow public read access" ON public.tools FOR SELECT USING (true);
CREATE POLICY "Allow public read access" ON public.courses FOR SELECT USING (true);

-- Políticas de Seguridad para Escritura (solo usuarios autenticados)
CREATE POLICY "Allow authenticated insert" ON public.projects FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated update" ON public.projects FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Allow authenticated delete" ON public.projects FOR DELETE TO authenticated USING (true);

CREATE POLICY "Allow authenticated insert" ON public.certificates FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated update" ON public.certificates FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Allow authenticated delete" ON public.certificates FOR DELETE TO authenticated USING (true);

CREATE POLICY "Allow authenticated insert" ON public.tools FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated update" ON public.tools FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Allow authenticated delete" ON public.tools FOR DELETE TO authenticated USING (true);

CREATE POLICY "Allow authenticated insert" ON public.courses FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated update" ON public.courses FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Allow authenticated delete" ON public.courses FOR DELETE TO authenticated USING (true);
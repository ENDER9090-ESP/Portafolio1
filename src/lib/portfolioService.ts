import { supabase } from './supabaseClient';
import type { Project, Certificate, Tool, Course } from '../types/portfolio';

export const PortfolioService = {
    // Proyectos
    async getProjects() {
        const { data, error } = await supabase
            .from('projects')
            .select('*')
            .order('created_at', { ascending: false });
        
        if (error) throw error;
        return data as Project[];
    },

    // Certificados
    async getCertificates() {
        const { data, error } = await supabase
            .from('certificates')
            .select('*')
            .order('date', { ascending: false });
        
        if (error) throw error;
        return data as Certificate[];
    },

    // Herramientas
    async getTools() {
        const { data, error } = await supabase
            .from('tools')
            .select('*')
            .order('category', { ascending: true });
        
        if (error) throw error;
        return data as Tool[];
    },

    // Cursos
    async getCourses() {
        const { data, error } = await supabase
            .from('courses')
            .select('*')
            .order('start_date', { ascending: false });
        
        if (error) throw error;
        return data as Course[];
    },

    // Suscripciones en tiempo real
    subscribeToChanges(table: string, callback: (payload: any) => void) {
        return supabase
            .channel(`public:${table}`)
            .on('postgres_changes', 
                { event: '*', schema: 'public', table },
                callback
            )
            .subscribe();
    }
};
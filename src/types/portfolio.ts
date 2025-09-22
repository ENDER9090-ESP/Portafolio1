export interface Project {
    id: string;
    title: string;
    description: string;
    image_url?: string;
    live_url?: string;
    technologies?: string[];
    created_at: string;
}

export interface Certificate {
    id: string;
    title: string;
    issuer: string;
    date: string;
    image_url?: string;
    credential_url?: string;
}

export interface Tool {
    id: string;
    name: string;
    category: string;
    proficiency: number;
    icon?: string;
}

export interface Course {
    id: string;
    title: string;
    institution: string;
    status: 'completed' | 'in_progress' | 'planned';
    start_date: string;
    end_date?: string;
    description?: string;
}

export interface PortfolioData {
    projects: Project[];
    certificates: Certificate[];
    tools: Tool[];
    courses: Course[];
}
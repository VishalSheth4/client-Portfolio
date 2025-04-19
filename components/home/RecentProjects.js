import Link from 'next/link'
import Image from 'next/image'
import ProjectCard from '../projects/ProjectCard'

// Sample project data - in a real app, this would come from a CMS or API
const featuredProjects = [
  {
    id: 1,
    title: 'E-commerce Website',
    description: 'A fully responsive e-commerce platform built with Next.js and Stripe integration.',
    image: '/images/project1.jpg',
    tags: ['Next.js', 'React', 'Tailwind CSS', 'Stripe'],
    category: 'Web Development',
    url: '/projects/ecommerce-website',
  },
  {
    id: 2,
    title: 'Portfolio for Photographer',
    description: 'A minimalist portfolio website for a professional photographer with gallery features.',
    image: '/images/project2.jpg',
    tags: ['React', 'CSS Grid', 'Framer Motion'],
    category: 'UI/UX Design',
    url: '/projects/photographer-portfolio',
  },
  {
    id: 3,
    title: 'Task Management App',
    description: 'A productivity app for managing tasks and projects with team collaboration features.',
    image: '/images/project3.jpg',
    tags: ['React', 'Node.js', 'MongoDB', 'Socket.io'],
    category: 'Full Stack',
    url: '/projects/task-management-app',
  },
]

export default function RecentProjects() {
  return (
    <section className="section bg-white">
      <div className="container">
        <h2 className="section-title">Recent Projects</h2>
        <p className="text-gray-600 text-center max-w-2xl mx-auto mb-12">
          Here are some of my recent works. Each project presented unique challenges and
          opportunities to implement creative solutions.
        </p>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {featuredProjects.map((project) => (
            <ProjectCard key={project.id} project={project} />
          ))}
        </div>

        <div className="text-center mt-12">
          <Link href="/projects" className="btn btn-primary">
            View All Projects
          </Link>
        </div>
      </div>
    </section>
  )
} 
import { useState } from 'react'
import Head from 'next/head'
import ProjectCard from '../components/projects/ProjectCard'

// Sample project data - in a real app, this would come from a CMS or API
const allProjects = [
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
  {
    id: 4,
    title: 'Restaurant Booking System',
    description: 'An online reservation system for restaurants with admin dashboard.',
    image: '/images/project4.jpg',
    tags: ['Next.js', 'Firebase', 'Tailwind CSS'],
    category: 'Web Development',
    url: '/projects/restaurant-booking',
  },
  {
    id: 5,
    title: 'Mobile Fitness App',
    description: 'A React Native fitness tracking app with workout plans and progress tracking.',
    image: '/images/project5.jpg',
    tags: ['React Native', 'Expo', 'Redux'],
    category: 'Mobile Development',
    url: '/projects/fitness-app',
  },
  {
    id: 6,
    title: 'Real Estate Listings',
    description: 'A property listing website with search filters and interactive maps.',
    image: '/images/project6.jpg',
    tags: ['React', 'Node.js', 'MongoDB', 'MapBox'],
    category: 'Full Stack',
    url: '/projects/real-estate',
  },
]

const categories = [
  'All',
  'Web Development',
  'UI/UX Design',
  'Full Stack',
  'Mobile Development',
]

export default function Projects() {
  const [selectedCategory, setSelectedCategory] = useState('All')
  
  const filteredProjects = selectedCategory === 'All'
    ? allProjects
    : allProjects.filter(project => project.category === selectedCategory)

  return (
    <div className="min-h-screen">
      <Head>
        <title>Projects | John Doe - Freelance Developer</title>
        <meta 
          name="description" 
          content="Browse through my portfolio of web development, design, and full-stack projects."
        />
      </Head>

      <section className="bg-primary/5 py-16">
        <div className="container">
          <h1 className="text-4xl md:text-5xl font-bold text-center mb-6">My Projects</h1>
          <p className="text-gray-600 text-center max-w-2xl mx-auto">
            Explore my latest work across various categories including web development,
            UI/UX design, and full-stack applications.
          </p>
        </div>
      </section>

      <section className="py-16">
        <div className="container">
          {/* Category filters */}
          <div className="flex flex-wrap justify-center gap-4 mb-12">
            {categories.map((category) => (
              <button
                key={category}
                onClick={() => setSelectedCategory(category)}
                className={`px-4 py-2 rounded-full text-sm font-medium transition-colors ${
                  selectedCategory === category
                    ? 'bg-primary text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                }`}
              >
                {category}
              </button>
            ))}
          </div>

          {/* Projects grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {filteredProjects.map((project) => (
              <ProjectCard key={project.id} project={project} />
            ))}
          </div>

          {/* Empty state */}
          {filteredProjects.length === 0 && (
            <div className="text-center py-12">
              <h3 className="text-xl font-medium mb-2">No projects found</h3>
              <p className="text-gray-600">
                No projects match the selected category. Try selecting a different category.
              </p>
            </div>
          )}
        </div>
      </section>
    </div>
  )
} 
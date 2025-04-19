import Link from 'next/link'
import Image from 'next/image'

export default function ProjectCard({ project }) {
  const { id, title, description, image, tags, category, url } = project

  return (
    <div className="bg-white rounded-lg shadow-md overflow-hidden transition-transform hover:scale-[1.02] hover:shadow-lg">
      <div className="relative h-48 w-full bg-gray-200">
        {/* In a real app, you would use real images here */}
        <div className="absolute inset-0 flex items-center justify-center bg-gradient-to-br from-primary/20 to-accent/20">
          <span className="text-lg font-medium text-primary">{title} Preview</span>
        </div>
      </div>
      
      <div className="p-6">
        <div className="mb-2">
          <span className="text-xs font-medium px-2 py-1 rounded-full bg-primary/10 text-primary">
            {category}
          </span>
        </div>
        
        <h3 className="text-xl font-bold mb-2">{title}</h3>
        
        <p className="text-gray-600 mb-4 line-clamp-3">{description}</p>
        
        <div className="flex flex-wrap gap-2 mb-6">
          {tags.map((tag, index) => (
            <span 
              key={index} 
              className="text-xs px-2 py-1 bg-gray-100 text-gray-600 rounded-full"
            >
              {tag}
            </span>
          ))}
        </div>
        
        <Link 
          href={url} 
          className="text-primary font-medium flex items-center hover:underline"
        >
          View Project
          <svg 
            className="w-4 h-4 ml-1"
            fill="none" 
            stroke="currentColor" 
            viewBox="0 0 24 24" 
            xmlns="http://www.w3.org/2000/svg"
          >
            <path 
              strokeLinecap="round" 
              strokeLinejoin="round" 
              strokeWidth={2}
              d="M14 5l7 7m0 0l-7 7m7-7H3"
            />
          </svg>
        </Link>
      </div>
    </div>
  )
} 
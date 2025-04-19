import { useState } from 'react'
import Head from 'next/head'
import Link from 'next/link'
import Image from 'next/image'

// Sample blog posts data - in a real app, this would come from a CMS or API
const blogPosts = [
  {
    id: 1,
    title: 'Getting Started with Next.js and Tailwind CSS',
    excerpt: 'Learn how to set up a new project using Next.js and Tailwind CSS from scratch, with tips for optimization and best practices.',
    image: '/images/blog1.jpg',
    date: 'April 12, 2023',
    author: 'John Doe',
    categories: ['Next.js', 'Tailwind CSS', 'Tutorial'],
    slug: 'getting-started-with-nextjs-and-tailwind',
  },
  {
    id: 2,
    title: 'Building Responsive Layouts with Tailwind CSS',
    excerpt: 'Discover techniques for creating beautiful, responsive layouts using Tailwind CSS utility classes and responsive design principles.',
    image: '/images/blog2.jpg',
    date: 'March 24, 2023',
    author: 'John Doe',
    categories: ['CSS', 'Tailwind CSS', 'Responsive Design'],
    slug: 'building-responsive-layouts-with-tailwind',
  },
  {
    id: 3,
    title: 'State Management in React Applications',
    excerpt: 'Explore different state management approaches in React, from useState and useContext to Redux and Zustand.',
    image: '/images/blog3.jpg',
    date: 'February 15, 2023',
    author: 'John Doe',
    categories: ['React', 'State Management', 'JavaScript'],
    slug: 'state-management-in-react-applications',
  },
  {
    id: 4,
    title: 'Creating Accessible Web Forms',
    excerpt: 'Learn how to build web forms that are accessible to all users, including those using assistive technologies.',
    image: '/images/blog4.jpg',
    date: 'January 30, 2023',
    author: 'John Doe',
    categories: ['Accessibility', 'HTML', 'Forms'],
    slug: 'creating-accessible-web-forms',
  },
  {
    id: 5,
    title: 'Introduction to Server-Side Rendering',
    excerpt: 'Understand the benefits of server-side rendering and how it can improve performance and SEO for your web applications.',
    image: '/images/blog5.jpg',
    date: 'January 8, 2023',
    author: 'John Doe',
    categories: ['Next.js', 'SSR', 'Performance'],
    slug: 'introduction-to-server-side-rendering',
  },
  {
    id: 6,
    title: 'Working with APIs in JavaScript',
    excerpt: 'Discover different methods for fetching and working with API data in JavaScript, including fetch, axios, and async/await.',
    image: '/images/blog6.jpg',
    date: 'December 12, 2022',
    author: 'John Doe',
    categories: ['JavaScript', 'API', 'Tutorial'],
    slug: 'working-with-apis-in-javascript',
  },
]

// Get all unique categories from blog posts
const allCategories = ['All', ...new Set(blogPosts.flatMap(post => post.categories))].sort()

export default function Blog() {
  const [selectedCategory, setSelectedCategory] = useState('All')
  const [searchQuery, setSearchQuery] = useState('')
  
  // Filter posts based on selected category and search query
  const filteredPosts = blogPosts.filter(post => {
    const matchesCategory = selectedCategory === 'All' || post.categories.includes(selectedCategory)
    const matchesSearch = post.title.toLowerCase().includes(searchQuery.toLowerCase()) || 
                          post.excerpt.toLowerCase().includes(searchQuery.toLowerCase())
    return matchesCategory && matchesSearch
  })

  return (
    <div className="min-h-screen">
      <Head>
        <title>Blog | John Doe - Freelance Developer</title>
        <meta 
          name="description" 
          content="Read articles and tutorials about web development, design, and programming."
        />
      </Head>

      {/* Header section */}
      <section className="bg-primary/5 py-16">
        <div className="container">
          <h1 className="text-4xl md:text-5xl font-bold text-center mb-6">Blog</h1>
          <p className="text-gray-600 text-center max-w-2xl mx-auto">
            Thoughts, tutorials, and insights about web development, design, and the latest
            technologies I work with.
          </p>
        </div>
      </section>

      <section className="py-16">
        <div className="container">
          {/* Search and filter controls */}
          <div className="mb-12">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-8">
              {/* Search */}
              <div className="w-full md:w-1/3">
                <div className="relative">
                  <input
                    type="text"
                    placeholder="Search articles..."
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    className="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-primary/30"
                  />
                  <svg
                    className="absolute right-3 top-1/2 transform -translate-y-1/2 h-5 w-5 text-gray-400"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                    />
                  </svg>
                </div>
              </div>

              {/* Categories */}
              <div className="flex-grow">
                <div className="flex flex-wrap gap-2">
                  {allCategories.map((category) => (
                    <button
                      key={category}
                      onClick={() => setSelectedCategory(category)}
                      className={`px-3 py-1 text-sm rounded-full transition-colors ${
                        selectedCategory === category
                          ? 'bg-primary text-white'
                          : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                      }`}
                    >
                      {category}
                    </button>
                  ))}
                </div>
              </div>
            </div>
            
            {/* Results summary */}
            {searchQuery && (
              <p className="text-gray-600">
                {filteredPosts.length} {filteredPosts.length === 1 ? 'result' : 'results'} found{' '}
                {selectedCategory !== 'All' && `in category "${selectedCategory}"`}
              </p>
            )}
          </div>

          {/* Blog post grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {filteredPosts.map((post) => (
              <div key={post.id} className="bg-white rounded-lg shadow-md overflow-hidden">
                <div className="relative h-48 w-full bg-gray-200">
                  {/* In a real app, you would use real images here */}
                  <div className="absolute inset-0 flex items-center justify-center bg-gradient-to-br from-gray-500/20 to-gray-700/20">
                    <span className="text-lg font-medium text-white">{post.title}</span>
                  </div>
                </div>
                
                <div className="p-6">
                  <div className="flex flex-wrap gap-2 mb-3">
                    {post.categories.map((category) => (
                      <span 
                        key={category} 
                        className="text-xs px-2 py-1 bg-gray-100 text-gray-600 rounded-full"
                      >
                        {category}
                      </span>
                    ))}
                  </div>
                  
                  <h2 className="text-xl font-bold mb-2">
                    <Link href={`/blog/${post.slug}`} className="hover:text-primary transition-colors">
                      {post.title}
                    </Link>
                  </h2>
                  
                  <p className="text-gray-600 mb-4 line-clamp-3">{post.excerpt}</p>
                  
                  <div className="flex justify-between items-center">
                    <span className="text-gray-500 text-sm">{post.date}</span>
                    <Link 
                      href={`/blog/${post.slug}`} 
                      className="text-primary font-medium hover:underline"
                    >
                      Read More
                    </Link>
                  </div>
                </div>
              </div>
            ))}
          </div>

          {/* Empty state */}
          {filteredPosts.length === 0 && (
            <div className="text-center py-12">
              <h3 className="text-xl font-medium mb-2">No articles found</h3>
              <p className="text-gray-600">
                Try adjusting your search or filter to find what you're looking for.
              </p>
            </div>
          )}
        </div>
      </section>
    </div>
  )
} 
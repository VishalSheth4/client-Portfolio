import { useRouter } from 'next/router'
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
    content: `
      <p>Next.js is a powerful React framework that enables functionality such as server-side rendering and static site generation. When combined with Tailwind CSS, a utility-first CSS framework, you can rapidly build beautiful, responsive websites with minimal effort.</p>
      
      <h2>Setting Up Your Project</h2>
      
      <p>To get started with Next.js and Tailwind CSS, follow these steps:</p>
      
      <ol>
        <li>Create a new Next.js app using <code>npx create-next-app@latest my-project</code></li>
        <li>Navigate to your project directory: <code>cd my-project</code></li>
        <li>Install Tailwind CSS and its dependencies: <code>npm install -D tailwindcss postcss autoprefixer</code></li>
        <li>Generate configuration files: <code>npx tailwindcss init -p</code></li>
        <li>Configure your template paths in <code>tailwind.config.js</code>:</li>
      </ol>
      
      <pre><code>
module.exports = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
      </code></pre>
      
      <p>Next, add the Tailwind directives to your CSS file:</p>
      
      <pre><code>
@tailwind base;
@tailwind components;
@tailwind utilities;
      </code></pre>
      
      <h2>Building Your First Component</h2>
      
      <p>Now that you have set up your project, let's create a simple component using Tailwind CSS classes:</p>
      
      <pre><code>
export default function Card({ title, description }) {
  return (
    <div className="p-6 max-w-sm mx-auto bg-white rounded-xl shadow-md flex items-center space-x-4">
      <div>
        <div className="text-xl font-medium text-black">{title}</div>
        <p className="text-gray-500">{description}</p>
      </div>
    </div>
  )
}
      </code></pre>
      
      <h2>Optimizing for Production</h2>
      
      <p>When building for production, Next.js and Tailwind CSS work together to optimize your site. Next.js automatically handles code splitting, minification, and other optimizations, while Tailwind CSS can be configured to purge unused styles, significantly reducing the CSS bundle size.</p>
      
      <p>To enable Tailwind's purge mode, make sure your <code>content</code> array in <code>tailwind.config.js</code> includes all files that contain Tailwind class names.</p>
      
      <h2>Conclusion</h2>
      
      <p>With Next.js and Tailwind CSS, you can build modern, responsive websites with enhanced performance and developer experience. The combination provides a powerful toolkit for web development, allowing you to focus more on building features and less on configuring tools.</p>
    `,
  },
  // Other blog posts...
]

export default function BlogPost() {
  const router = useRouter()
  const { slug } = router.query
  
  // Find the post that matches the slug
  const post = blogPosts.find(post => post.slug === slug)
  
  // Show loading state if the router is not ready or post is not found
  if (router.isFallback || !post) {
    return (
      <div className="container py-20 text-center">
        <p className="text-lg">Loading...</p>
      </div>
    )
  }

  return (
    <div className="min-h-screen">
      <Head>
        <title>{post.title} | John Doe's Blog</title>
        <meta name="description" content={post.excerpt} />
      </Head>

      {/* Blog header */}
      <section className="bg-primary/5 py-16">
        <div className="container">
          <div className="max-w-3xl mx-auto">
            {/* Categories */}
            <div className="flex flex-wrap gap-2 justify-center mb-6">
              {post.categories.map((category) => (
                <Link
                  key={category}
                  href={`/blog?category=${category}`}
                  className="text-xs px-3 py-1 bg-primary/10 text-primary rounded-full hover:bg-primary/20 transition-colors"
                >
                  {category}
                </Link>
              ))}
            </div>
            
            {/* Title */}
            <h1 className="text-3xl md:text-4xl lg:text-5xl font-bold text-center mb-6">
              {post.title}
            </h1>
            
            {/* Meta info */}
            <div className="flex justify-center items-center gap-4 text-gray-600 mb-8">
              <span>{post.date}</span>
              <span>•</span>
              <span>By {post.author}</span>
            </div>
          </div>
        </div>
      </section>

      {/* Blog content */}
      <section className="py-16">
        <div className="container">
          <div className="max-w-3xl mx-auto">
            {/* Featured image */}
            <div className="mb-8 rounded-lg overflow-hidden bg-gray-100 h-64 flex items-center justify-center">
              {/* In a real app, you would use real images here */}
              <span className="text-xl font-medium text-gray-500">Featured Image</span>
            </div>
            
            {/* Content */}
            <article className="prose prose-lg max-w-none">
              <div dangerouslySetInnerHTML={{ __html: post.content }} />
            </article>
            
            {/* Author bio */}
            <div className="mt-12 pt-8 border-t">
              <div className="flex items-center">
                <div className="h-16 w-16 rounded-full bg-gray-300 flex items-center justify-center mr-4">
                  <span className="text-sm font-medium text-gray-600">JD</span>
                </div>
                <div>
                  <h3 className="font-bold text-lg">{post.author}</h3>
                  <p className="text-gray-600">
                    Freelance web developer specializing in React, Next.js, and Node.js.
                    Passionate about creating beautiful, user-friendly websites and apps.
                  </p>
                </div>
              </div>
            </div>
            
            {/* Navigation */}
            <div className="mt-12 flex justify-between">
              <Link 
                href="/blog" 
                className="flex items-center text-primary hover:underline"
              >
                <svg 
                  className="w-4 h-4 mr-1"
                  fill="none" 
                  stroke="currentColor" 
                  viewBox="0 0 24 24"
                >
                  <path 
                    strokeLinecap="round" 
                    strokeLinejoin="round" 
                    strokeWidth={2}
                    d="M10 19l-7-7m0 0l7-7m-7 7h18"
                  />
                </svg>
                Back to Blog
              </Link>
            </div>
          </div>
        </div>
      </section>
    </div>
  )
}

// In a real Next.js app, you would use getStaticPaths and getStaticProps
// to generate the blog posts at build time instead of client-side rendering:

/*
export async function getStaticPaths() {
  // This would typically fetch data from a CMS or API
  const posts = blogPosts
  
  // Get the paths we want to pre-render based on posts
  const paths = posts.map((post) => ({
    params: { slug: post.slug },
  }))
  
  // We'll pre-render only these paths at build time
  return { paths, fallback: 'blocking' }
}

export async function getStaticProps({ params }) {
  // Fetch post data based on slug
  const post = blogPosts.find(post => post.slug === params.slug)
  
  // If the post doesn't exist, return 404
  if (!post) {
    return {
      notFound: true,
    }
  }
  
  // Pass post data to the page via props
  return {
    props: { post },
    // Revalidate every hour
    revalidate: 3600,
  }
}
*/ 
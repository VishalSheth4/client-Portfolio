import Link from 'next/link'
import Image from 'next/image'

export default function Hero() {
  return (
    <section className="py-20 bg-gradient-to-br from-gray-50 to-gray-100">
      <div className="container">
        <div className="flex flex-col md:flex-row items-center justify-between gap-12">
          <div className="w-full md:w-1/2 space-y-6">
            <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold text-dark">
              <span className="text-primary">Hello, I'm John Doe.</span>
              <br />
              Freelance Web Developer
            </h1>
            <p className="text-lg text-gray-600 max-w-lg">
              Specializing in creating beautiful, responsive websites and web applications 
              using modern technologies like React, Next.js, and Node.js.
            </p>
            <div className="flex flex-wrap gap-4">
              <Link href="/projects" className="btn btn-primary">
                View My Work
              </Link>
              <Link href="/contact" className="btn btn-outline">
                Contact Me
              </Link>
            </div>
          </div>
          
          <div className="w-full md:w-1/2 flex justify-center">
            <div className="relative w-72 h-72 md:w-96 md:h-96 rounded-full bg-primary/10 flex items-center justify-center">
              {/* This is where a profile image would go. Using a placeholder for now */}
              <div className="absolute inset-4 rounded-full bg-gradient-to-br from-primary/20 to-accent/20 flex items-center justify-center">
                <div className="font-bold text-7xl text-primary">JD</div>
              </div>
            </div>
          </div>
        </div>
        
        <div className="mt-20">
          <h2 className="text-2xl font-bold text-center mb-8">Trusted By</h2>
          <div className="flex flex-wrap justify-center gap-8 md:gap-16 opacity-70">
            {/* Placeholder for client logos */}
            {['Company 1', 'Company 2', 'Company 3', 'Company 4'].map((company, index) => (
              <div key={index} className="text-xl font-bold text-gray-400">
                {company}
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  )
} 
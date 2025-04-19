import { useState } from 'react';
import GlassCard from '../components/GlassCard';
import GlassButton from '../components/GlassButton';
import GlassModal from '../components/GlassModal';
import Head from 'next/head';
import Image from 'next/image';

export default function Portfolio() {
  const [isContactModalOpen, setIsContactModalOpen] = useState(false);
  const [isProjectModalOpen, setIsProjectModalOpen] = useState(false);
  const [selectedProject, setSelectedProject] = useState(null);

  const projects = [
    {
      id: 1,
      title: "E-commerce Platform",
      description: "A modern e-commerce solution built with Next.js and Stripe",
      tags: ["Next.js", "Stripe", "Tailwind CSS"],
      image: "/projects/ecommerce.jpg"
    },
    {
      id: 2,
      title: "AI Dashboard",
      description: "Analytics dashboard with AI-powered insights",
      tags: ["React", "Python", "TensorFlow"],
      image: "/projects/dashboard.jpg"
    },
    {
      id: 3,
      title: "Mobile App",
      description: "Cross-platform mobile app for task management",
      tags: ["React Native", "Firebase"],
      image: "/projects/mobile.jpg"
    }
  ];

  const skills = [
    { name: "React", level: 90 },
    { name: "Next.js", level: 85 },
    { name: "Node.js", level: 80 },
    { name: "TypeScript", level: 85 },
    { name: "Python", level: 75 },
    { name: "UI/UX Design", level: 80 }
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-100 via-purple-100 to-pink-100 dark:from-blue-900 dark:via-purple-900 dark:to-pink-900">
      <Head>
        <title>John Doe - Full Stack Developer</title>
        <meta name="description" content="Portfolio of John Doe - Full Stack Developer specializing in React and Node.js" />
      </Head>

      <div className="max-w-7xl mx-auto px-4 py-12 space-y-12">
        {/* Hero Section */}
        <GlassCard className="text-center py-16">
          <div className="relative w-32 h-32 mx-auto mb-8 rounded-full overflow-hidden">
            <Image
              src="/profile.jpg"
              alt="John Doe"
              layout="fill"
              objectFit="cover"
              className="rounded-full"
            />
          </div>
          <h1 className="text-5xl md:text-6xl font-bold mb-4 bg-clip-text text-transparent bg-gradient-to-r from-blue-600 to-purple-600">
            John Doe
          </h1>
          <p className="text-xl md:text-2xl text-gray-600 dark:text-gray-300 mb-8">
            Full Stack Developer & UI/UX Designer
          </p>
          <div className="flex justify-center space-x-4">
            <GlassButton variant="primary" onClick={() => setIsContactModalOpen(true)}>
              Contact Me
            </GlassButton>
            <GlassButton onClick={() => window.open('/resume.pdf')}>
              Download CV
            </GlassButton>
          </div>
        </GlassCard>

        {/* About Section */}
        <GlassCard>
          <h2 className="text-3xl font-bold mb-6 bg-clip-text text-transparent bg-gradient-to-r from-blue-600 to-purple-600">
            About Me
          </h2>
          <p className="text-gray-600 dark:text-gray-300 mb-4">
            I'm a passionate Full Stack Developer with 5+ years of experience in building
            modern web applications. I specialize in React, Node.js, and cloud technologies.
          </p>
          <p className="text-gray-600 dark:text-gray-300">
            When I'm not coding, you can find me exploring new technologies, writing technical
            blogs, or contributing to open-source projects.
          </p>
        </GlassCard>

        {/* Skills Section */}
        <GlassCard>
          <h2 className="text-3xl font-bold mb-8 bg-clip-text text-transparent bg-gradient-to-r from-blue-600 to-purple-600">
            Skills
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {skills.map((skill) => (
              <div key={skill.name} className="space-y-2">
                <div className="flex justify-between">
                  <span className="font-medium">{skill.name}</span>
                  <span>{skill.level}%</span>
                </div>
                <div className="h-2 bg-glass-light dark:bg-glass-dark rounded-full overflow-hidden">
                  <div
                    className="h-full bg-gradient-to-r from-blue-500 to-purple-500"
                    style={{ width: `${skill.level}%` }}
                  />
                </div>
              </div>
            ))}
          </div>
        </GlassCard>

        {/* Projects Section */}
        <div className="space-y-6">
          <h2 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-blue-600 to-purple-600">
            Featured Projects
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {projects.map((project) => (
              <GlassCard
                key={project.id}
                className="cursor-pointer hover:scale-105 transition-transform"
                onClick={() => {
                  setSelectedProject(project);
                  setIsProjectModalOpen(true);
                }}
              >
                <div className="relative h-48 -mx-6 -mt-6 mb-6">
                  <Image
                    src={project.image}
                    alt={project.title}
                    layout="fill"
                    objectFit="cover"
                    className="rounded-t-2xl"
                  />
                </div>
                <h3 className="text-xl font-bold mb-2">{project.title}</h3>
                <p className="text-gray-600 dark:text-gray-300 mb-4">
                  {project.description}
                </p>
                <div className="flex flex-wrap gap-2">
                  {project.tags.map((tag) => (
                    <span
                      key={tag}
                      className="px-3 py-1 bg-glass-light dark:bg-glass-dark rounded-full text-sm"
                    >
                      {tag}
                    </span>
                  ))}
                </div>
              </GlassCard>
            ))}
          </div>
        </div>

        {/* Contact Modal */}
        <GlassModal isOpen={isContactModalOpen} onClose={() => setIsContactModalOpen(false)}>
          <h2 className="text-2xl font-bold mb-6">Get in Touch</h2>
          <form className="space-y-4">
            <div>
              <label className="block text-sm font-medium mb-1">Name</label>
              <input
                type="text"
                className="w-full px-4 py-2 rounded-lg bg-glass-light dark:bg-glass-dark border border-glass-light dark:border-glass-dark focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium mb-1">Email</label>
              <input
                type="email"
                className="w-full px-4 py-2 rounded-lg bg-glass-light dark:bg-glass-dark border border-glass-light dark:border-glass-dark focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium mb-1">Message</label>
              <textarea
                rows="4"
                className="w-full px-4 py-2 rounded-lg bg-glass-light dark:bg-glass-dark border border-glass-light dark:border-glass-dark focus:outline-none focus:ring-2 focus:ring-blue-500"
              ></textarea>
            </div>
            <div className="flex justify-end space-x-4">
              <GlassButton variant="danger" onClick={() => setIsContactModalOpen(false)}>
                Cancel
              </GlassButton>
              <GlassButton variant="primary">Send Message</GlassButton>
            </div>
          </form>
        </GlassModal>

        {/* Project Modal */}
        <GlassModal
          isOpen={isProjectModalOpen}
          onClose={() => {
            setIsProjectModalOpen(false);
            setSelectedProject(null);
          }}
        >
          {selectedProject && (
            <>
              <div className="relative h-64 -mx-6 -mt-6 mb-6">
                <Image
                  src={selectedProject.image}
                  alt={selectedProject.title}
                  layout="fill"
                  objectFit="cover"
                  className="rounded-t-2xl"
                />
              </div>
              <h2 className="text-2xl font-bold mb-4">{selectedProject.title}</h2>
              <p className="text-gray-600 dark:text-gray-300 mb-6">
                {selectedProject.description}
              </p>
              <div className="flex flex-wrap gap-2 mb-6">
                {selectedProject.tags.map((tag) => (
                  <span
                    key={tag}
                    className="px-3 py-1 bg-glass-light dark:bg-glass-dark rounded-full text-sm"
                  >
                    {tag}
                  </span>
                ))}
              </div>
              <div className="flex justify-end space-x-4">
                <GlassButton variant="primary">View Live</GlassButton>
                <GlassButton>View Code</GlassButton>
              </div>
            </>
          )}
        </GlassModal>
      </div>
    </div>
  );
} 
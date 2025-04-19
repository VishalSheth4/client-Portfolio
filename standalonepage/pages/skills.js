import Head from 'next/head'

// Sample skills data - in a real app, this would come from a CMS or API
const skills = [
  { name: 'React', level: 90, category: 'Frontend' },
  { name: 'Next.js', level: 85, category: 'Frontend' },
  { name: 'JavaScript', level: 90, category: 'Frontend' },
  { name: 'TypeScript', level: 75, category: 'Frontend' },
  { name: 'HTML5', level: 95, category: 'Frontend' },
  { name: 'CSS3/SCSS', level: 90, category: 'Frontend' },
  { name: 'Tailwind CSS', level: 95, category: 'Frontend' },
  { name: 'Redux', level: 80, category: 'Frontend' },
  { name: 'Node.js', level: 80, category: 'Backend' },
  { name: 'Express.js', level: 75, category: 'Backend' },
  { name: 'MongoDB', level: 70, category: 'Backend' },
  { name: 'PostgreSQL', level: 65, category: 'Backend' },
  { name: 'Firebase', level: 80, category: 'Backend' },
  { name: 'RESTful APIs', level: 85, category: 'Backend' },
  { name: 'GraphQL', level: 60, category: 'Backend' },
  { name: 'Git/GitHub', level: 85, category: 'Tools' },
  { name: 'Docker', level: 60, category: 'Tools' },
  { name: 'CI/CD', level: 65, category: 'Tools' },
  { name: 'Figma', level: 75, category: 'Design' },
  { name: 'Adobe XD', level: 70, category: 'Design' },
]

// Sample experience data - in a real app, this would come from a CMS or API
const experiences = [
  {
    id: 1,
    role: 'Senior Frontend Developer',
    company: 'Tech Solutions Inc.',
    period: 'Jan 2021 - Present',
    description: 'Leading frontend development for enterprise web applications using React, Next.js, and TypeScript. Implementing CI/CD pipelines and mentoring junior developers.',
  },
  {
    id: 2,
    role: 'Full Stack Developer',
    company: 'Digital Innovations',
    period: 'Mar 2018 - Dec 2020',
    description: 'Developed and maintained multiple web applications using React, Node.js, and MongoDB. Collaborated with designers to implement responsive and accessible user interfaces.',
  },
  {
    id: 3,
    role: 'Web Developer',
    company: 'Creative Agency',
    period: 'Jun 2016 - Feb 2018',
    description: 'Built interactive websites for clients in various industries. Focused on responsive design and cross-browser compatibility using HTML, CSS, and JavaScript.',
  },
  {
    id: 4,
    role: 'Junior Developer',
    company: 'Startup Hub',
    period: 'Jan 2015 - May 2016',
    description: 'Assisted in developing web applications and learned modern web development practices. Gained experience with frontend frameworks and version control systems.',
  },
]

// Sample certification data - in a real app, this would come from a CMS or API
const certifications = [
  {
    id: 1,
    name: 'AWS Certified Developer',
    issuer: 'Amazon Web Services',
    date: 'Jan 2022',
    url: '#',
  },
  {
    id: 2,
    name: 'Professional React Developer',
    issuer: 'React Training',
    date: 'Mar 2021',
    url: '#',
  },
  {
    id: 3,
    name: 'MongoDB Certified Developer',
    issuer: 'MongoDB University',
    date: 'Nov 2020',
    url: '#',
  },
  {
    id: 4,
    name: 'Full Stack Web Development',
    issuer: 'Udacity',
    date: 'Aug 2019',
    url: '#',
  },
]

const SkillBar = ({ name, level }) => {
  return (
    <div className="mb-4">
      <div className="flex justify-between items-center mb-1">
        <span className="font-medium text-gray-700">{name}</span>
        <span className="text-sm text-gray-500">{level}%</span>
      </div>
      <div className="h-2 bg-gray-200 rounded-full overflow-hidden">
        <div 
          className="h-full bg-primary rounded-full"
          style={{ width: `${level}%` }}
        />
      </div>
    </div>
  )
}

export default function Skills() {
  // Group skills by category
  const skillsByCategory = skills.reduce((acc, skill) => {
    if (!acc[skill.category]) {
      acc[skill.category] = []
    }
    acc[skill.category].push(skill)
    return acc
  }, {})

  return (
    <div className="min-h-screen">
      <Head>
        <title>Skills & Experience | John Doe - Freelance Developer</title>
        <meta 
          name="description" 
          content="Discover my technical skills, professional experience, and certifications in web development."
        />
      </Head>

      {/* Header section */}
      <section className="bg-primary/5 py-16">
        <div className="container">
          <h1 className="text-4xl md:text-5xl font-bold text-center mb-6">Skills & Experience</h1>
          <p className="text-gray-600 text-center max-w-2xl mx-auto">
            A comprehensive overview of my technical expertise, professional journey,
            and ongoing commitment to learning and development.
          </p>
        </div>
      </section>

      {/* Skills section */}
      <section className="py-16 bg-white">
        <div className="container">
          <h2 className="section-title">Technical Skills</h2>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-12">
            {Object.entries(skillsByCategory).map(([category, categorySkills]) => (
              <div key={category} className="mb-8">
                <h3 className="text-xl font-bold mb-6 pb-2 border-b">{category}</h3>
                <div>
                  {categorySkills.map((skill) => (
                    <SkillBar key={skill.name} name={skill.name} level={skill.level} />
                  ))}
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Experience timeline section */}
      <section className="py-16 bg-gray-50">
        <div className="container">
          <h2 className="section-title">Professional Experience</h2>
          
          <div className="max-w-3xl mx-auto">
            {experiences.map((exp, index) => (
              <div key={exp.id} className="relative pl-8 pb-8">
                {/* Timeline vertical line */}
                {index < experiences.length - 1 && (
                  <div className="absolute left-3 top-3 bottom-0 w-px bg-gray-300" />
                )}
                
                {/* Timeline dot */}
                <div className="absolute left-0 top-3 h-6 w-6 rounded-full bg-primary flex items-center justify-center">
                  <div className="h-2 w-2 rounded-full bg-white" />
                </div>
                
                {/* Content */}
                <div>
                  <h3 className="text-xl font-bold">{exp.role}</h3>
                  <div className="flex flex-wrap gap-x-2 text-gray-600 mb-2">
                    <span>{exp.company}</span>
                    <span>•</span>
                    <span>{exp.period}</span>
                  </div>
                  <p className="text-gray-700">{exp.description}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Certifications section */}
      <section className="py-16 bg-white">
        <div className="container">
          <h2 className="section-title">Certifications & Education</h2>
          
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            {certifications.map((cert) => (
              <div key={cert.id} className="p-6 border rounded-lg hover:shadow-md transition-shadow">
                <h3 className="font-bold text-lg mb-2">{cert.name}</h3>
                <p className="text-gray-600 mb-1">{cert.issuer}</p>
                <p className="text-gray-500 text-sm">{cert.date}</p>
                <a 
                  href={cert.url} 
                  target="_blank" 
                  rel="noopener noreferrer" 
                  className="text-primary text-sm mt-2 inline-block hover:underline"
                >
                  View Certificate
                </a>
              </div>
            ))}
          </div>
        </div>
      </section>
    </div>
  )
} 
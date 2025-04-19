import Link from 'next/link'

// Sample skills data - in a real app, this would come from a CMS or API
const skills = [
  { name: 'React', level: 90 },
  { name: 'Next.js', level: 85 },
  { name: 'Node.js', level: 80 },
  { name: 'Tailwind CSS', level: 95 },
  { name: 'JavaScript', level: 90 },
  { name: 'TypeScript', level: 75 },
]

const SkillBar = ({ name, level }) => {
  return (
    <div className="mb-6">
      <div className="flex justify-between items-center mb-2">
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

export default function SkillsSummary() {
  return (
    <section className="section bg-gray-50">
      <div className="container">
        <h2 className="section-title">My Skills</h2>
        <p className="text-gray-600 text-center max-w-2xl mx-auto mb-12">
          I'm constantly learning and improving my skills to stay up-to-date with the latest technologies
          and best practices in web development.
        </p>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-12 max-w-4xl mx-auto">
          {/* Skills column 1 */}
          <div>
            {skills.slice(0, 3).map((skill) => (
              <SkillBar key={skill.name} name={skill.name} level={skill.level} />
            ))}
          </div>
          
          {/* Skills column 2 */}
          <div>
            {skills.slice(3, 6).map((skill) => (
              <SkillBar key={skill.name} name={skill.name} level={skill.level} />
            ))}
          </div>
        </div>

        <div className="text-center mt-12">
          <Link href="/skills" className="btn btn-primary">
            View All Skills
          </Link>
        </div>
      </div>
    </section>
  )
} 
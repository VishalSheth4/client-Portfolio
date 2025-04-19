import Link from 'next/link';

const GlassFooter = () => {
  const socialLinks = [
    { href: '#', label: 'GitHub', icon: 'github' },
    { href: '#', label: 'LinkedIn', icon: 'linkedin' },
    { href: '#', label: 'Twitter', icon: 'twitter' },
    { href: '#', label: 'Instagram', icon: 'instagram' }
  ];

  return (
    <footer className="mt-20">
      <div className="backdrop-blur-xl bg-white/20 dark:bg-black/20 border-t border-white/20 dark:border-gray-800/20">
        <div className="max-w-7xl mx-auto px-4 py-12">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {/* Brand */}
            <div className="space-y-4">
              <h3 className="text-2xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-blue-600 to-purple-600">
                Portfolio
              </h3>
              <p className="text-gray-600 dark:text-gray-300">
                Building beautiful digital experiences with modern technologies.
              </p>
            </div>

            {/* Quick Links */}
            <div>
              <h4 className="text-lg font-semibold mb-4 text-gray-800 dark:text-gray-200">
                Quick Links
              </h4>
              <ul className="space-y-2">
                <li>
                  <Link href="/projects" className="text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400">
                    Projects
                  </Link>
                </li>
                <li>
                  <Link href="/blog" className="text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400">
                    Blog
                  </Link>
                </li>
                <li>
                  <Link href="/contact" className="text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400">
                    Contact
                  </Link>
                </li>
              </ul>
            </div>

            {/* Social Links */}
            <div>
              <h4 className="text-lg font-semibold mb-4 text-gray-800 dark:text-gray-200">
                Connect
              </h4>
              <div className="flex space-x-4">
                {socialLinks.map((link) => (
                  <a
                    key={link.label}
                    href={link.href}
                    className="p-2 rounded-full bg-white/10 dark:bg-black/10 hover:bg-white/20 dark:hover:bg-black/20 transition-colors"
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    <span className="sr-only">{link.label}</span>
                    <svg
                      className="h-5 w-5 text-gray-700 dark:text-gray-300"
                      fill="currentColor"
                      viewBox="0 0 24 24"
                    >
                      {/* Add your social media icons here */}
                    </svg>
                  </a>
                ))}
              </div>
            </div>
          </div>

          <div className="mt-8 pt-8 border-t border-white/10 dark:border-gray-800/10">
            <p className="text-center text-gray-600 dark:text-gray-400">
              © {new Date().getFullYear()} Your Name. All rights reserved.
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default GlassFooter; 
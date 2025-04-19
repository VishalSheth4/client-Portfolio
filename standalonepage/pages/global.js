const globals = {
    siteTitle: "John Doe - Full Stack Developer",
    siteDescription: "Portfolio of John Doe - Full Stack Developer specializing in React and Node.js",
    contactEmail: "johndoe@example.com",
    skills: [
      { name: "React", level: 90 },
      { name: "Next.js", level: 85 },
      { name: "Node.js", level: 80 },
      { name: "TypeScript", level: 85 },
      { name: "Python", level: 75 },
      { name: "UI/UX Design", level: 80 },
    ],
    projects: [
      {
        id: 1,
        title: "E-commerce Platform",
        description: "A modern e-commerce solution built with Next.js and Stripe",
        tags: ["Next.js", "Stripe", "Tailwind CSS"],
        image: "/projects/ecommerce.jpg",
      },
      {
        id: 2,
        title: "AI Dashboard",
        description: "Analytics dashboard with AI-powered insights",
        tags: ["React", "Python", "TensorFlow"],
        image: "/projects/dashboard.jpg",
      },
      {
        id: 3,
        title: "Mobile App",
        description: "Cross-platform mobile app for task management",
        tags: ["React Native", "Firebase"],
        image: "/projects/mobile.jpg",
      },
    ],
  };
  
  export default globals;
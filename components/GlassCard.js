import React from 'react';

const GlassCard = ({ children, className = '' }) => {
  return (
    <div className={`
      relative overflow-hidden rounded-2xl
      bg-gradient-glass dark:bg-gradient-glass-dark
      backdrop-blur-glass
      border border-glass-light dark:border-glass-dark
      shadow-glass
      p-6
      transition-all duration-300
      hover:shadow-glass-lg
      ${className}
    `}>
      {children}
    </div>
  );
};

export default GlassCard; 
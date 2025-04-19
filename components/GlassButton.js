import React from 'react';

const GlassButton = ({ children, onClick, className = '', variant = 'default' }) => {
  const variants = {
    default: 'bg-glass-light dark:bg-glass-dark text-gray-800 dark:text-white',
    primary: 'bg-blue-500/20 text-blue-700 dark:text-blue-300',
    success: 'bg-green-500/20 text-green-700 dark:text-green-300',
    danger: 'bg-red-500/20 text-red-700 dark:text-red-300',
  };

  return (
    <button
      onClick={onClick}
      className={`
        px-6 py-2.5
        rounded-lg
        backdrop-blur-glass
        border border-glass-light dark:border-glass-dark
        shadow-glass-sm
        transition-all duration-300
        hover:shadow-glass
        active:scale-95
        disabled:opacity-50 disabled:cursor-not-allowed
        ${variants[variant]}
        ${className}
      `}
    >
      {children}
    </button>
  );
};

export default GlassButton; 
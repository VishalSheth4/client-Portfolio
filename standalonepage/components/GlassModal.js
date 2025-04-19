import React, { useEffect } from 'react';
import { createPortal } from 'react-dom';

const GlassModal = ({ isOpen, onClose, children, className = '' }) => {
  useEffect(() => {
    if (isOpen) {
      document.body.style.overflow = 'hidden';
    } else {
      document.body.style.overflow = 'unset';
    }
    return () => {
      document.body.style.overflow = 'unset';
    };
  }, [isOpen]);

  if (!isOpen) return null;

  return createPortal(
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
      {/* Backdrop */}
      <div
        className="absolute inset-0 bg-black/20 backdrop-blur-sm"
        onClick={onClose}
      />
      
      {/* Modal Content */}
      <div
        className={`
          relative z-10
          w-full max-w-lg
          bg-gradient-glass dark:bg-gradient-glass-dark
          backdrop-blur-glass
          border border-glass-light dark:border-glass-dark
          shadow-glass
          rounded-2xl
          p-6
          transform transition-all duration-300
          ${className}
        `}
      >
        {children}
      </div>
    </div>,
    document.body
  );
};

export default GlassModal; 
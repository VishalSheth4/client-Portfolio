import { useState } from 'react'
import Head from 'next/head'
import GlassCard from '../components/GlassCard'
import GlassButton from '../components/GlassButton'
import GlassMap from '../components/GlassMap'

export default function Contact() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    subject: '',
    message: '',
  })
  
  const [formStatus, setFormStatus] = useState({
    isSubmitting: false,
    isSubmitted: false,
    error: null,
  })
  
  const [validation, setValidation] = useState({
    email: { isValid: true, message: '' },
    message: { isValid: true, message: '' },
  })
  
  const MAX_MESSAGE_LENGTH = 500
  const MIN_MESSAGE_LENGTH = 10

  // Email validation function
  const validateEmail = (email) => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    return emailRegex.test(email)
  }

  // Message length validation
  const validateMessage = (message) => {
    if (message.length < MIN_MESSAGE_LENGTH) {
      return { isValid: false, message: `Message must be at least ${MIN_MESSAGE_LENGTH} characters` }
    }
    if (message.length > MAX_MESSAGE_LENGTH) {
      return { isValid: false, message: `Message cannot exceed ${MAX_MESSAGE_LENGTH} characters` }
    }
    return { isValid: true, message: '' }
  }

  const handleChange = (e) => {
    const { name, value } = e.target
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }))

    // Validate email in real-time
    if (name === 'email') {
      setValidation(prev => ({
        ...prev,
        email: {
          isValid: validateEmail(value),
          message: validateEmail(value) ? '' : 'Please enter a valid email address'
        }
      }))
    }

    // Validate message length in real-time
    if (name === 'message') {
      setValidation(prev => ({
        ...prev,
        message: validateMessage(value)
      }))
    }
  }
  
  const handleSubmit = async (e) => {
    e.preventDefault();
    setFormStatus(prev => ({
      ...prev,
      isSubmitting: true,
      isSubmitted: false,
      error: null,
    }));

    try {
      // First check if backend is running
      try {
        const healthCheck = await fetch('http://localhost:5001/api/health');
        if (!healthCheck.ok) {
          throw new Error('Backend server is not responding properly');
        }
      } catch (healthError) {
        throw new Error('Unable to connect to the server. Please make sure the backend server is running on port 5001.');
      }

      const response = await fetch('http://localhost:5001/api/contact', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.message || 'Failed to submit form');
      }

      const data = await response.json();
      setFormStatus(prev => ({
        ...prev,
        isSubmitting: false,
        isSubmitted: true,
        error: null,
      }));
      setFormData({
        name: '',
        email: '',
        subject: '',
        message: '',
      });
    } catch (err) {
      console.error('Error submitting form:', err);
      setFormStatus(prev => ({
        ...prev,
        isSubmitting: false,
        isSubmitted: false,
        error: err.message,
      }));
    }
  };

  // Replace with your actual Google Maps API key
  const GOOGLE_MAPS_API_KEY = process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY
  const officeAddress = 'Katargam, Surat, Gujarat, India'

  const contactInfo = [
    {
      icon: (
        <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
        </svg>
      ),
      title: 'Office Location',
      content: officeAddress
    },
    {
      icon: (
        <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
        </svg>
      ),
      title: 'Phone Number',
      content: '+91 1234567890'
    },
    {
      icon: (
        <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
        </svg>
      ),
      title: 'Email Address',
      content: 'contact@yourwebsite.com'
    }
  ]

  return (
    <>
      <Head>
        <title>Contact Us - Portfolio</title>
        <meta 
          name="description" 
          content="Get in touch with us for any inquiries or collaboration opportunities."
        />
      </Head>

      <div className="max-w-7xl mx-auto px-4 py-12 space-y-12">
        {/* Header */}
        <GlassCard className="text-center py-12">
          <h1 className="text-4xl md:text-5xl font-bold mb-4 bg-clip-text text-transparent bg-gradient-to-r from-blue-600 to-purple-600">
            Get in Touch
          </h1>
          <p className="text-xl text-gray-600 dark:text-gray-300">
            Have a question or want to work together?
          </p>
        </GlassCard>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          {/* Contact Form */}
          <GlassCard>
            <h2 className="text-2xl font-bold mb-6 text-gray-800 dark:text-white">Send us a Message</h2>
            
            {/* Success Message */}
            {formStatus.isSubmitted && (
              <div className="mb-6 p-4 bg-green-500/20 border border-green-500 rounded-lg">
                <div className="flex items-center">
                  <svg className="w-5 h-5 mr-2 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                  </svg>
                  <p className="text-green-200">Message sent successfully! I'll get back to you soon.</p>
                </div>
              </div>
            )}
            
            {/* Error Message */}
            {formStatus.error && (
              <div className="mb-6 p-4 bg-red-500/20 border border-red-500 rounded-lg">
                <div className="flex items-center">
                  <svg className="w-5 h-5 mr-2 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                  <p className="text-red-200">{formStatus.error}</p>
                </div>
              </div>
            )}
            
            <form onSubmit={handleSubmit} className="space-y-6">
              <div>
                <label className="block text-sm font-medium mb-2 text-gray-700 dark:text-gray-200">Name</label>
                <input
                  type="text"
                  name="name"
                  value={formData.name}
                  onChange={handleChange}
                  className="w-full px-4 py-2 rounded-lg bg-white/80 dark:bg-gray-800/80 border border-gray-200 dark:border-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-900 dark:text-white"
                  required
                  minLength="2"
                />
              </div>
              <div>
                <label className="block text-sm font-medium mb-2 text-gray-700 dark:text-gray-200">Email</label>
                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  className={`w-full px-4 py-2 rounded-lg bg-white/80 dark:bg-gray-800/80 border ${
                    validation.email.isValid ? 'border-gray-200 dark:border-gray-700' : 'border-red-500'
                  } focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-900 dark:text-white`}
                  required
                />
                {!validation.email.isValid && (
                  <p className="mt-1 text-sm text-red-500">{validation.email.message}</p>
                )}
              </div>
              <div>
                <label className="block text-sm font-medium mb-2 text-gray-700 dark:text-gray-200">Subject</label>
                <input
                  type="text"
                  name="subject"
                  value={formData.subject}
                  onChange={handleChange}
                  className="w-full px-4 py-2 rounded-lg bg-white/80 dark:bg-gray-800/80 border border-gray-200 dark:border-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-900 dark:text-white"
                  required
                  minLength="5"
                />
              </div>
              <div>
                <div className="flex justify-between items-center mb-2">
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-200">Message</label>
                  <span className={`text-sm ${
                    formData.message.length > MAX_MESSAGE_LENGTH ? 'text-red-500' : 'text-gray-500'
                  }`}>
                    {formData.message.length}/{MAX_MESSAGE_LENGTH}
                  </span>
                </div>
                <textarea
                  name="message"
                  value={formData.message}
                  onChange={handleChange}
                  rows="4"
                  className={`w-full px-4 py-2 rounded-lg bg-white/80 dark:bg-gray-800/80 border ${
                    validation.message.isValid ? 'border-gray-200 dark:border-gray-700' : 'border-red-500'
                  } focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-900 dark:text-white`}
                  required
                  minLength={MIN_MESSAGE_LENGTH}
                  maxLength={MAX_MESSAGE_LENGTH}
                ></textarea>
                {!validation.message.isValid && (
                  <p className="mt-1 text-sm text-red-500">{validation.message.message}</p>
                )}
              </div>
              <GlassButton 
                type="submit" 
                variant="primary" 
                className="w-full"
                disabled={formStatus.isSubmitting || !validation.email.isValid || !validation.message.isValid}
              >
                {formStatus.isSubmitting ? 'Sending...' : 'Send Message'}
              </GlassButton>
            </form>
          </GlassCard>

          {/* Contact Information and Map */}
          <div className="space-y-8">
            <GlassCard>
              <h2 className="text-2xl font-bold mb-6 text-gray-800 dark:text-white">Contact Information</h2>
              <div className="space-y-6">
                {contactInfo.map((info, index) => (
                  <div key={index} className="flex items-start space-x-4">
                    <div className="p-3 rounded-full bg-blue-100 dark:bg-blue-900/30">
                      <div className="text-blue-600 dark:text-blue-400">
                        {info.icon}
                      </div>
                    </div>
                    <div>
                      <h3 className="font-medium text-gray-900 dark:text-white">{info.title}</h3>
                      <p className="text-gray-600 dark:text-gray-300">{info.content}</p>
                    </div>
                  </div>
                ))}
              </div>
            </GlassCard>

            {/* Map */}
            <GlassCard>
              <h2 className="text-2xl font-bold mb-6 text-gray-800 dark:text-white">Our Location</h2>
              <GlassMap
                apiKey={GOOGLE_MAPS_API_KEY}
                address={officeAddress}
              />
            </GlassCard>
          </div>
        </div>
      </div>
    </>
  )
} 
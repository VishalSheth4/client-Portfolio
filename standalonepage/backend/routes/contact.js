const express = require('express');
const router = express.Router();
const nodemailer = require('nodemailer');
const fs = require('fs');
const path = require('path');

// Create a transporter object using SMTP transport
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS
  }
});

// Path to messages storage
const messagesPath = path.join(__dirname, '../data/messages.json');

// Ensure messages.json exists
if (!fs.existsSync(messagesPath)) {
  fs.writeFileSync(messagesPath, JSON.stringify({ messages: [] }, null, 2));
}

// Function to save message
const saveMessage = (message) => {
  try {
    let messages = { messages: [] };
    
    // Read existing messages
    const data = fs.readFileSync(messagesPath, 'utf8');
    messages = JSON.parse(data);
    
    // Add new message with timestamp
    messages.messages.push({
      ...message,
      timestamp: new Date().toISOString(),
      status: 'pending'
    });
    
    // Save updated messages
    fs.writeFileSync(messagesPath, JSON.stringify(messages, null, 2));
    return true;
  } catch (error) {
    console.error('Error saving message:', error);
    return false;
  }
};

// Function to update message status
const updateMessageStatus = (index, status, error = null) => {
  try {
    const data = fs.readFileSync(messagesPath, 'utf8');
    const messages = JSON.parse(data);
    
    if (messages.messages[index]) {
      messages.messages[index].status = status;
      if (error) {
        messages.messages[index].error = error;
      }
      fs.writeFileSync(messagesPath, JSON.stringify(messages, null, 2));
      return true;
    }
    return false;
  } catch (error) {
    console.error('Error updating message status:', error);
    return false;
  }
};

router.post('/', async (req, res) => {
  try {
    const { name, email, subject, message } = req.body;

    // Validate input
    if (!name || !email || !subject || !message) {
      return res.status(400).json({
        success: false,
        message: 'All fields are required'
      });
    }

    // Save message to storage
    const messageSaved = saveMessage({ name, email, subject, message });
    if (!messageSaved) {
      throw new Error('Failed to save message');
    }

    // Get the index of the newly added message
    const data = fs.readFileSync(messagesPath, 'utf8');
    const messages = JSON.parse(data);
    const messageIndex = messages.messages.length - 1;

    try {
      // Email content
      const mailOptions = {
        from: process.env.EMAIL_USER,
        to: process.env.EMAIL_USER,
        replyTo: email,
        subject: `Portfolio Contact: ${subject}`,
        text: `
          Name: ${name}
          Email: ${email}
          Subject: ${subject}
          Message: ${message}
        `,
        html: `
          <h2>New Contact Form Submission</h2>
          <p><strong>Name:</strong> ${name}</p>
          <p><strong>Email:</strong> ${email}</p>
          <p><strong>Subject:</strong> ${subject}</p>
          <p><strong>Message:</strong></p>
          <p>${message}</p>
        `
      };

      // Send email
      await transporter.sendMail(mailOptions);
      
      // Update message status to sent
      updateMessageStatus(messageIndex, 'sent');
      
      res.json({
        success: true,
        message: 'Message sent successfully!'
      });
    } catch (emailError) {
      console.error('Error sending email:', emailError);
      // Update message status to failed
      updateMessageStatus(messageIndex, 'failed', emailError.message);
      
      res.status(500).json({
        success: false,
        message: 'Failed to send email. Please try again later.',
        error: process.env.NODE_ENV === 'development' ? emailError.message : undefined
      });
    }
  } catch (error) {
    console.error('Error processing contact form:', error);
    
    res.status(500).json({
      success: false,
      message: 'Failed to process your message. Please try again later.',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
});

module.exports = router; 
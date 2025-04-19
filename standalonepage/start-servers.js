const { spawn } = require('child_process');
const path = require('path');

// Function to start a server
function startServer(command, args, options) {
  const server = spawn(command, args, options);
  
  server.stdout.on('data', (data) => {
    console.log(`${options.cwd ? 'Backend' : 'Frontend'}: ${data}`);
  });

  server.stderr.on('data', (data) => {
    console.error(`${options.cwd ? 'Backend' : 'Frontend'} Error: ${data}`);
  });

  server.on('close', (code) => {
    console.log(`${options.cwd ? 'Backend' : 'Frontend'} process exited with code ${code}`);
  });

  return server;
}

// Start backend server
const backendServer = startServer('node', ['start-server.js'], {
  cwd: path.join(__dirname, 'backend'),
  shell: true
});

// Start frontend server
const frontendServer = startServer('npm', ['run', 'dev'], {
  cwd: __dirname,
  shell: true
});

// Handle process termination
process.on('SIGINT', () => {
  console.log('Shutting down servers...');
  backendServer.kill();
  frontendServer.kill();
  process.exit();
}); 
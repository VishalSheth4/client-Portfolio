const { exec } = require('child_process');
const http = require('http');
const fs = require('fs');
const path = require('path');

// List of ports to try
const PORTS = [5001, 5002, 5003, 5004, 5005];
const DEFAULT_PORT = PORTS[0];

// Function to check if port is in use
function isPortInUse(port) {
  return new Promise((resolve) => {
    const server = http.createServer()
      .listen(port)
      .on('error', () => {
        resolve(true);
      })
      .on('listening', () => {
        server.close();
        resolve(false);
      });
  });
}

// Function to kill process using a port
async function killProcessOnPort(port) {
  return new Promise((resolve) => {
    if (process.platform === 'win32') {
      exec(`netstat -ano | findstr :${port}`, (error, stdout) => {
        if (stdout) {
          const pid = stdout.split('\n')[0].split(/\s+/)[5];
          if (pid) {
            exec(`taskkill /F /PID ${pid}`, (error) => {
              if (error) {
                console.error(`Failed to kill process ${pid}:`, error);
              } else {
                console.log(`Successfully killed process ${pid} using port ${port}`);
              }
              resolve();
            });
          } else {
            resolve();
          }
        } else {
          resolve();
        }
      });
    } else {
      exec(`lsof -ti:${port} | xargs kill -9`, (error) => {
        if (error) {
          console.error(`Failed to kill process on port ${port}:`, error);
        } else {
          console.log(`Successfully killed process using port ${port}`);
        }
        resolve();
      });
    }
  });
}

// Function to find an available port
async function findAvailablePort() {
  for (const port of PORTS) {
    const inUse = await isPortInUse(port);
    if (!inUse) {
      return port;
    }
    console.log(`Port ${port} is in use, trying next port...`);
  }
  throw new Error('No available ports found');
}

// Function to update .env file with new port
function updateEnvFile(port) {
  const envPath = path.join(__dirname, '.env');
  let envContent = '';
  
  if (fs.existsSync(envPath)) {
    envContent = fs.readFileSync(envPath, 'utf8');
    envContent = envContent.replace(/PORT=\d+/g, `PORT=${port}`);
  } else {
    envContent = `PORT=${port}\nNODE_ENV=development`;
  }
  
  fs.writeFileSync(envPath, envContent);
  console.log(`Updated .env file with PORT=${port}`);
}

// Function to start the server
async function startServer() {
  try {
    // Kill any existing processes on the default port
    await killProcessOnPort(DEFAULT_PORT);
    
    // Wait for port to be freed
    await new Promise(resolve => setTimeout(resolve, 2000));
    
    // Find an available port
    const port = await findAvailablePort();
    console.log(`Using port ${port}`);
    
    // Update .env file with the new port
    updateEnvFile(port);
    
    // Start the server
    const server = exec('npm run dev', (error, stdout, stderr) => {
      if (error) {
        console.error(`Error starting server: ${error}`);
        return;
      }
      console.log(stdout);
      console.error(stderr);
    });

    server.stdout.on('data', (data) => {
      console.log(data);
    });

    server.stderr.on('data', (data) => {
      console.error(data);
    });

    // Handle server exit
    server.on('exit', (code) => {
      if (code !== 0) {
        console.error(`Server exited with code ${code}`);
      }
    });

  } catch (error) {
    console.error('Error:', error);
    process.exit(1);
  }
}

// Start the server
startServer(); 
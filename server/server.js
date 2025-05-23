// server.js

// Import the Express.js framework
const express = require('express');

// Create an instance of the Express application
const app = express();

// Define the port the server will listen on
// Use the PORT environment variable if available, otherwise default to 9000
const port = process.env.PORT || 9000; // --- CHANGED TO 9000 ---

// Middleware to parse JSON bodies from incoming requests
app.use(express.json());

// --- Express Router Setup ---
const apiRouter = express.Router();

apiRouter.get('/', (req, res) => {
  res.json({
    message: 'Welcome to the API!',
    version: '1.0'
  });
});

apiRouter.get('/data', (req, res) => {
  res.json({
    message: 'This is some data from the API via router',
    timestamp: new Date().toISOString()
  });
});

app.use('/api', apiRouter);

// --- End Express Router Setup ---

app.get('/', (req, res) => {
  res.send('Hello from your Express server!');
});


// Start the server and listen for incoming requests on the specified port
app.listen(port, () => {
  console.log(`Express server listening at http://localhost:${port}`);
  console.log('You can open your browser and navigate to the URL above.');
  console.log('Try visiting:');
  console.log(`- http://localhost:${port}/`);
  console.log(`- http://localhost:${port}/api`);
  console.log(`- http://localhost:${port}/api/data`);
});

// To run this application with nodemon:
// ... (rest of the comments remain the same)

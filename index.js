const express = require('express');
const path = require('path');
const fs = require('fs');
const { spawn } = require('child_process');

const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'), err => {
    if (err) {
      res.status(500).send('Error loading index.html');
    }
  });
});

// Use spawn to execute the go.sh script when server starts
const child = spawn('bash', [path.join(__dirname, 'go.sh')]);

// Listen for stdout data
child.stdout.on('data', (data) => {
  console.log(`go.sh Output: ${data}`);
});

// Listen for stderr data
child.stderr.on('data', (data) => {
  console.error(`go.sh Errors: ${data}`);
});

// Listen for close event
child.on('close', (code) => {
  console.log(`go.sh script ended with code ${code}`);
});

// Start the server
app.listen(port, () => {
  console.log(`Server started and listening on port ${port}`);
});

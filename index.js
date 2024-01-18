const express = require('express');
const path = require('path');
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

const bashScript = path.join(__dirname, 'go.sh');  // 确保 go.sh 脚本在正确的位置
const bash = spawn('bash', [bashScript]);

bash.stdout.on('data', (data) => {
  console.log(`stdout: ${data}`);
});

bash.stderr.on('data', (data) => {
  console.log(`stderr: ${data}`);
});

bash.on('error', (err) => {
  console.log(`Failed to start subprocess: ${err}`);
});

bash.on('exit', (code, signal) => {
  if (code) {
    console.log(`Child process exited with code ${code}`);
  }
  if (signal) {
    console.log(`Child process exited with signal ${signal}`);
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server started and listening on port ${port}`);
});

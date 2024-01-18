const express = require('express');
const path = require('path');
const fs = require('fs');
const { exec } = require('child_process');

const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'), err => {
    if (err) {
      res.status(500).send('Error loading index.html');
    }
  });
});

// Use bash to execute the go.sh script when server starts
exec('bash ' + path.join(__dirname, 'go.sh'), (err) => {
  if(err){
    console.error(`Error executing go.sh: ${err}`);
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server started and listening on port ${port}`);
});

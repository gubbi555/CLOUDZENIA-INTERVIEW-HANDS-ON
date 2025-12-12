const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({
    message: 'Hello from Microservice',
    timestamp: new Date().toISOString(),
    service: 'nodejs-microservice',
    environment: 'dev'
  });
});

app.get('/api', (req, res) => {
  res.json({
    message: 'Hello from Microservice',
    timestamp: new Date().toISOString(),
    service: 'nodejs-microservice',
    environment: 'dev'
  });
});

app.get('/health', (req, res) => {
  res.json({ status: 'healthy', environment: 'dev' });
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Microservice running on port ${port}`);
  console.log('Environment: dev');
});

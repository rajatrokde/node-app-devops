const express = require('express');
const app = express();

const PORT = 3000;

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: "UP" });
});

// Main route
app.get('/', (req, res) => {
  res.send("DevOps Node Application Running Successfully using Express project by RR Infotech Pune");
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});

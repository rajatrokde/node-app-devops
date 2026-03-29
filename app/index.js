const express = require('express');
const app = express();

const PORT = 3000;

// Health check endpoint (important for DevOps / monitoring)
app.get('/health', (req, res) => {
  res.status(200).json({ status: "UP" });
});

// Main route
app.get('/', (req, res) => {
  res.send("🚀 DevOps Node App Running Successfully using express !");
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

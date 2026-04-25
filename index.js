const http = require('http');

const requestListener = (req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World from DevOps Lab!\n');
};

const app = http.createServer(requestListener);

// We only listen if this file is run directly, not when imported by tests
if (require.main === module) {
  const port = process.env.PORT || 3000;
  app.listen(port, () => {
    console.log(`Server running at port ${port}`);
  });
}

module.exports = app; // Export for testing
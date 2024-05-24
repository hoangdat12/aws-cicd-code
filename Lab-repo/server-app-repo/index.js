require('dotenv').config();
const express = require('express');
// const { connectToMongoDB } = require('./database');
const path = require('path');
const cors = require('cors');
var morgan = require('morgan');

const app = express();
app.use(express.json());
app.use(cors());
app.use(morgan('common'));

app.use(function (req, res, next) {
  // Website you wish to allow to connect
  res.setHeader('Access-Control-Allow-Origin', '*');

  // Request methods you wish to allow
  res.setHeader(
    'Access-Control-Allow-Methods',
    'GET, POST, OPTIONS, PUT, PATCH, DELETE'
  );

  // Request headers you wish to allow
  res.setHeader(
    'Access-Control-Allow-Headers',
    'X-Requested-With,content-type'
  );

  // Set to true if you need the website to include cookies in the requests sent
  // to the API (e.g. in case you use sessions)
  res.setHeader('Access-Control-Allow-Credentials', true);

  // Pass to next layer of middleware
  next();
});

// Health check endpoint
app.get('/', (req, res) => {
  res.status(200).json({ msg: 'New version for blue/green' });
});

app.use(express.static(path.join(__dirname, 'build')));

const router = require('./routes');

app.use('/api', router);

const port = process.env.PORT || 5000;

async function startServer() {
  // await connectToMongoDB();
  app.listen(port, () => {
    console.log(`Server is listening on http://localhost:${port}`);
  });
}
startServer();

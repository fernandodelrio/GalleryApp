const express = require('express');
const path = require('path');
const favicon = require('serve-favicon');
const bodyParser = require('body-parser');
const exphbs  = require('express-handlebars');
const routes = require('./routes/index');
const fs = require('fs');
const app = express();

const env = process.env.NODE_ENV || 'development';
app.locals.ENV = env;
app.locals.ENV_DEVELOPMENT = env == 'development';

app.use(bodyParser.raw({
  limit: '100mb'
}));

app.use('/', routes);

var cacheFolder = path.join(__dirname, "buck-cache")
if (!fs.existsSync(cacheFolder)) {
  fs.mkdirSync(cacheFolder)
}

module.exports = app;

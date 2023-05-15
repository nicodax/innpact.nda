process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment');

environment.devtool = 'inline-source-map';
module.exports = environment.toWebpackConfig();

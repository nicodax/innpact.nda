process.env.NODE_ENV = process.env.NODE_ENV || 'production';

const environment = require('./environment');

environment.optimization = {
  minimize: 'true',
};
environment.devtool = 'nosources-source-map';

module.exports = environment.toWebpackConfig();

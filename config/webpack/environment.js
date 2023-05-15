const { environment } = require('@rails/webpacker');
const webpack = require('webpack');
const crypto = require('crypto');

// By default Webpack 4 users md4 hash, which is not available on NodeJS 17+ (OpenSSL 3)
// Can't update to Webpack 5 cause @rails/webpacker was abandoned before version 6 was released
// Can't also use `openssl-legacy-provider` as github actions clears the
// NODE_OPTIONS environment variable
const cryptoOrigCreateHash = crypto.createHash;
crypto.createHash = (algorithm) => cryptoOrigCreateHash(algorithm === 'md4' ? 'sha512' : algorithm);

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  jQuery: 'jquery',
}));

module.exports = environment;

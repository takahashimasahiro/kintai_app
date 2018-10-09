process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
var webpack = require('webpack');

environment.config.set('output.library', ['Packs', 'users'])

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  "Tether": 'tether',
  Popper: ['popper.js', 'default']
}))

module.exports = environment.toWebpackConfig()

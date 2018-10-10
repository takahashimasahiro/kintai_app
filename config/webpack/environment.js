const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
// Webpacker 3.3.0 以降は set ではなく prepend を使用する
environment.plugins.prepend( 
  'Provide',
  new webpack.ProvidePlugin({
    jQuery: 'jquery/dist/jquery',
    Popper: 'popper.js/dist/popper'
  })
)


module.exports = environment

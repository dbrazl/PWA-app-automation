echo '
 _____ _ _ _ _____    _____ _____ _____    _____ _____ _____ _____ _____ _____ _____ _____ _____ 
|  _  | | | |  _  |  |  _  |  _  |  _  |  |   __|   __|   | |   __| __  |  _  |_   _|     | __  |
|   __| | | |     |  |     |   __|   __|  |  |  |   __| | | |   __|    -|     | | | |  |  |    -|
|__|  |_____|__|__|  |__|__|__|  |__|     |_____|_____|_|___|_____|__|__|__|__| |_| |_____|__|__|

A ReactJS project.                                                                                                 
By.: Daniel B. Lopes - dbrazl.com.br'

$project = Read-Host 'Input the project name'
$author = Read-Host 'Input author name'
$email = Read-Host 'Input the author/project email'
$web = Read-Host 'Input the author/project web-site'

mkdir $project
cd $project
mkdir front-end, back-end
cd front-end
mkdir dist, src, components, src/css, src/img
clear
echo 'wait...'

cd src
$indexJSX = "import React from 'react';
import ReactDOM from 'react-dom';
import './img/favicon.ico';
import './css/index.css';

ReactDOM.render(
  <h1>Bem-vindo ao React!</h1>,
  document.querySelector('#main')
)"
New-Item -path 'index.jsx' -ItemType File
Set-content -path 'index.jsx' -Value $indexJSX
clear
echo 'wait...'

$indexHTML = '<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="shortcut icon" href="img/favicon.ico">
  <title>nome-do-projeto</title>
</head>

<body>
  <main id="main"></main>
</body>

</html>'
New-Item -path 'index.html' -ItemType File
Set-content -path 'index.html' -Value $indexHTML
clear
echo 'wait...'

cd ..
npm init -y
clear
echo 'wait...'

rm package.json
$package = '{
  "name": "'+$project+'",
  "version": "1.0.0",
  "scripts": {
    "start": "set NODE_ENV=development && node_modules\\.bin\\webpack-dev-server",
    "build": "set NODE_ENV=production && node_modules\\.bin\\webpack"
  },
  "keywords": [],
  "author": "'+$author+' <'+$email+'> (http://'+$web+')",
  "license": "ISC"
}'
New-Item -path 'package.json' -ItemType File
Set-content -path 'package.json' -Value $package
clear
echo 'wait...'

yarn add react@15.6.1 react-dom@15.6.1
clear
echo 'wait...'

yarn add -D babel-core@6.25.0 babel-preset-es2015@6.24.1 babel-preset-react@6.24.1 babel-loader@7.1.0
clear
echo 'wait...'

yarn add -D webpack@3.0.0 webpack-dev-server@2.5.0
clear
echo 'wait...'

yarn add -D html-webpack-plugin@2.29.0
clear
echo 'wait...'

yarn add -D file-loader@0.11.2
clear
echo 'wait...'

yarn add -D style-loader@0.18.2 css-loader@0.28.4
clear
echo 'wait...'

yarn add -D extract-text-webpack-plugin@2.1.2
clear
echo 'wait...'

yarn add -D uglifyjs-webpack-plugin@0.4.6
clear
echo 'wait...'

cd src/css
$indexCSS = '#main {
  padding: 0;
  margin: 0;
  border: 0;
}'
New-Item -path 'index.css' -ItemType File
Set-content -path 'index.css' -Value $indexCSS
clear
echo 'wait...'

cd ../..

$webpack = "const webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');

plugins = [
  new HtmlWebpackPlugin({
    filename: 'index.html',
    template: path.join(__dirname, 'src/index.html')
  }),
  new ExtractTextPlugin('style.css')
]

if (process.env.NODE_ENV === 'production') {
  this.plugins.push(new webpack.DefinePlugin({
    'process.env': {
      NODE_ENV: JSON.stringify(process.env.NODE_ENV)
    }
  }));
  this.plugins.push(new webpack.optimize.UglifyJsPlugin());
}

module.exports = {
  entry: path.join(__dirname, 'src/index.jsx'),

  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'bundle.js'
  },

  resolve: {
    extensions: ['.js', '.jsx']
  },

  plugins: plugins,

  module: {
    rules: [
      {
        test: /.jsx?$/,
        exclude: /node_modules/,
        include: path.join(__dirname, 'src'),
        use: [
          {
            loader: 'babel-loader',
            options: {
              presets: ['es2015', 'react']
            }
          }
        ]
      },
      {
        test: /\.(jpe?g|ico|png|gif\svg)$/i,
        loader: 'file-loader?name=img/[name].[ext]'
      },
      {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: 'css-loader'
        })
      }
    ]
  },

  devServer: {
    publicPath: '/',
    contentBase: './dist'
  }
};"
New-Item -path 'webpack.config.js' -ItemType File
Set-content -path 'webpack.config.js' -Value $webpack
clear

echo "
*--------------------------------------------------------------------------------------*
| Put the favicon img in front-end/src/img. Its require to run the server!             |
*--------------------------------------------------------------------------------------*"

echo "
 ______ _____  ______  _____  ______   _    _  
| |      | |  | |  \ \  | |  / |      | |  | | 
| |----  | |  | |  | |  | |  '------. | |--| | 
|_|     _|_|_ |_|  |_| _|_|_  ____|_/ |_|  |_|                                         

"
cd ../..
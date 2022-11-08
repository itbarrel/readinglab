const path = require('path')
const rails = require('esbuild-rails')

const railsEnv = process.env.RAILS_ENV || 'development'
const optimize = railsEnv !== 'development'

require("esbuild").build({
  // logLevel: 'debug',
  metafile: true,
  entryPoints: ['javascript/application.js'],
  bundle: true,
  outdir: 'builds',
  absWorkingDir: path.join(process.cwd(), "app/assets"),
  watch: process.argv.includes("--watch"),
  minify: optimize,
  sourcemap: false,
  // watch: true,
  plugins: [rails()],
  loader: {
    ".png": "file",
    ".jpg": "file",
    ".jpeg": "file",
    ".svg": "file",
    ".gif": "file",
    ".ttf": "file",
    ".eot": "file",
    ".html": "file",
    ".woff2": "file",
    ".woff": "file",
  },
})
.then(() => console.log('⚡ Styles & Scripts Compiled! ⚡ '))
.catch(() => process.exit(1));

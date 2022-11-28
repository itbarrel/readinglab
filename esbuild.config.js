const path = require("path");
const rails = require("esbuild-rails");
const esbuild = require("esbuild");

const watch = process.argv.includes("--watch");

const railsEnv = process.env.RAILS_ENV || "development";
const optimize = railsEnv !== "development";
const errorFilePath = `esbuild_error_${railsEnv}.txt`;

const fs = require("fs");

function handleError(error) {
  if (error) fs.writeFileSync(errorFilePath, error.toString());
  else if (fs.existsSync(errorFilePath))
    fs.truncate(errorFilePath, 0, () => {});
}

esbuild
  .build({
    // logLevel: 'debug',
    metafile: true,
    entryPoints: ["javascript/application.js"],
    bundle: true,
    outdir: "builds",
    absWorkingDir: path.join(process.cwd(), "app/assets"),
    watch: watch && { onRebuild: handleError },
    minify: optimize,
    sourcemap: false,
    // watch: true,
    plugins: [rails()],
    loader: {
      ".png": "dataurl",
      ".jpg": "file",
      ".jpeg": "file",
      ".svg": "text",
      ".gif": "file",
      ".ttf": "file",
      ".eot": "file",
      ".html": "file",
      ".woff2": "file",
      ".woff": "file",
    },
  })
  .then(() => console.log("⚡ Styles & Scripts Compiled! ⚡ "))
  .catch(() => process.exit(1));

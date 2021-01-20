import legacy from "@vitejs/plugin-legacy"
const syncDir = require("sync-directory");
const { resolve } = require("path");
// import nodeResolve from "@rollup/plugin-node-resolve";
// import commonjs from "@rollup/plugin-commonjs";

export default ({ _command, mode }) => {
  let prod = mode === "production"

  syncDir(
    resolve(__dirname, "./static"),
    resolve(__dirname, "../priv/static"),
    { deleteOrphaned: true }
  )

  return {
    clearScreen: false,
    alias: {
      '/@static': prod ?
        resolve(__dirname, 'static') :
        __dirname,
      // '/@static': __dirname,
      '/@css': resolve(__dirname, 'css'),
      '/@js': resolve(__dirname, 'js')
    },
    build: {
      manifest: true,
      minify: false,
      assetsDir: "vite",
      outDir: "../priv/static",
      target: "modules",
      sourceMap: "true",
      cleanCssOptions: {
        rebase: true,
        rebaseTo: resolve(__dirname, 'static')
      },
      rollupOptions: {
        // external: ["phoenix", "phoenix_live_view"],
        input: "js/app.js",
        output: {
          interop: "auto",
          sourcemap: "inline",
          format: "iife",
          // globals: {
          //   'phoenix': "phoenix",
          //   'phoenix_live_view': "LiveSocket"
          // }
        }
      }
    },
    plugins: [
      legacy({
        targets: ['defaults']
      })
    ]
  }
}

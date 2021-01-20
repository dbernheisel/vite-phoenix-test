// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "vite/dynamic-import-polyfill"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "topbar"
import "/@css/app.css"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

topbar.config({
  barThickness: 2,
  shadowBlur: 5,
  barColors: ["#F56565", "#9B2C2C"],
})

let topbarDelay = null;

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", _info => {
  clearTimeout(topbarDelay);
  topbarDelay = setTimeout(() => topbar.show(), 200);
})
window.addEventListener("phx:page-loading-stop", _info => {
  clearTimeout(topbarDelay);
  topbar.hide();
})

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket


// Test JS interop
import phoenixImgUrl from "/@static/images/phoenix.png"
const jsDiv = document.createElement("div")
const jsImg = document.createElement("img")
const jsAttr = document.createAttribute("phx-update")
const jsText = document.createTextNode("Created from JavaScript")
jsAttr.value = "ignore"
jsDiv.appendChild(jsText)
jsDiv.setAttributeNode(jsAttr)

jsImg.src = phoenixImgUrl
const headerEl = document.querySelector("header");
headerEl.after(jsDiv)
headerEl.after(jsImg)

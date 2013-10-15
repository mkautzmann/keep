# Deezer Video Controller Content Script Background Proxy
# Author: Matheus R. Kautzmann

do (window, document, chrome) ->

  bgConnection = undefined

  # Connect to the background code
  connect = ->
    conn = chrome.runtime.connect
      name: "deezer"
    return conn

  # Inject the deezer monitor in the deezer tab
  injectDeezerMonitor = ->
    script = document.createElement "script"
    script.type = "text/javascript"
    script.src = chrome.extension.getURL(
      "src/deezer-video-controller-monitor.js")
    document.getElementsByTagName("head")[0].appendChild script

  # Add the message handler that will proxy the messages to the monitor
  addMessageHandler = ->
    bgConnection.onMessage.addListener (msg) ->
      window.postMessage
        type: "deezer-controller"
        cod: msg.cod
      , "http://www.deezer.com/"

  bgConnection = connect()
  injectDeezerMonitor()
  addMessageHandler()


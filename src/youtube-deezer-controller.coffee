# Deezer YouTube Controller Injected script
# Author: Matheus R. Kautzmann

do (window, document, chrome) ->

  # Opening conenction to the background script
  bgConnection = chrome.runtime.connect
    name: "youtube"

  # Injecting the YouTube monitor in the youtube tabs
  injectYouTubeMonitor = ->
    script = document.createElement "script"
    script.type = "text/javascript"
    script.src = chrome.extension.getURL(
      "src/youtube-deezer-controller-monitor.js")
    document.getElementsByTagName("head")[0].appendChild script

  injectYouTubeMonitor()

  # Telling deezer to start
  startDeezer = ->
    bgConnection.postMessage
      cod: 1

  # Telling deezer to stop
  stopDeezer = ->
    bgConnection.postMessage
      cod: 0

  # Receiving message from monitor current status
  window.addEventListener "message", (event) ->
    if event.data.type? and event.data.type is "youtube-controller"
      if event.data.cod?
        switch event.data.cod
          when 1 then startDeezer()
          when 0 then stopDeezer()


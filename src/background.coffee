# Background file for Deezer Video Controller Chrome extension
# Author: Matheus R. Kautzmann

# Background code that opens connection with both Deezer and YouTube.

# Deezer tab
deezer = null

# Current deezer status
deezerStatus = null

# YouTube tabs
youtubes = []

# Player enabled?
playerEnabled = null

# Check if the user wants to stop music when playing videos
checkIfEnabled = ->
  chrome.storage.sync.get 'playerEnabled', (item) ->
    if item.playerEnabled?
      playerEnabled = item.playerEnabled
    else
      chrome.storage.sync.set
        playerEnabled: true
      playerEnabled = true

# Disable the play/stop music functions
disable = ->
  playerEnabled = false
  chrome.storage.sync.set
    playerEnabled: false

# Enable the play/stop music functions
enable = ->
  playerEnabled = true
  chrome.storage.sync.set
    playerEnabled: true

do (window, chrome, console) ->

  # Send message to deezer tab
  sendMessageToDeezer = (port, msg) ->
    status = checkYouTubeStatus port, msg
    msg =
      cod: status
    console.log "Attempting to call deezer"
    if deezer? and playerEnabled
      if deezerStatus != status
        console.log "Message to Deezer"
        console.log msg
        deezerStatus = status
        deezer.postMessage msg

  # Check the current YouTube status
  checkYouTubeStatus = (port, msg) ->
    status = 1
    if youtubes.length is 0
      return status

    for youtube in youtubes
      if youtube['id'] is port.portId_
        youtube['status'] = msg.cod

      if youtube['status'] isnt 1
        status = youtube['status']

    return status

  # First, we need to know if the user wants the extension to work
  checkIfEnabled()

  # Setting the listener on background. Waiting for connections...
  chrome.runtime.onConnect.addListener (port) ->
    # Deezer connecting, logging it's address
    if port.name is "deezer" and not deezer?
      console.log "Deezer connected"
      deezer = port
      # Deezer's gone, setting it's address to null
      deezer.onDisconnect.addListener ->
        console.log "Deezer disconnected"
        deezer = null
        deezerStatus = null

    # YouTube connecting
    if port.name is "youtube"
      console.log "YouTube connected"
      # Adding YouTube to the stack
      youtubes.unshift
        status: 1
        port: port
        id: port.portId_
      # YouTube's gone, inform deezer and pull it off the stack
      port.onDisconnect.addListener ->
        console.log "YouTube disconnected"
        msg =
          cod: 1
        sendMessageToDeezer port, msg
        youtubes.splice 0, 1
      # Message incoming from YouTube, pass to Deezer Controller.
      port.onMessage.addListener (msg) ->
        console.log "Message from YT"
        sendMessageToDeezer port, msg

do (document, chrome) ->
  # Check if the extension is current enabled by the user
  playerEnabled = chrome.extension.getBackgroundPage().playerEnabled

  # Variable that controls the switch element
  checkbox = document.getElementById("player-enabled")

  # If playerEnabled then set the switch accordingly
  if playerEnabled?
    checkbox.checked = playerEnabled

  # Get the switch current status
  currentStatus = checkbox.checked

  # When the user switch the enabled switch inform the background code
  checkbox.addEventListener 'change', ->
    newStatus = !currentStatus
    if newStatus
      chrome.extension.getBackgroundPage().enable()
    else
      chrome.extension.getBackgroundPage().disable()

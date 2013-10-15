# Deezer Monitor = Injected in Deezer's web page

#dzPlayer wrapper
class DeezerController

  constructor: ->
    @loadDeezer()

  loadDeezer: ->
    dzPlayer = window.dzPlayer
    if dzPlayer?
      @dzPlayer = dzPlayer
      @wasPlaying = @dzPlayer.isPlaying()
    else
      setTimeout @loadDeezer, 500

  play: ->
    if @dzPlayer.paused and @wasPlaying
      @dzPlayer.play()

  pause: ->
    @wasPlaying = @dzPlayer.isPlaying()
    if not @dzPlayer.paused
      @dzPlayer.pause()

  getVolume: ->
    return @dzPlayer.getVolume()

  setVolume: (value) ->
    if 0 <= value <= 1
      @dzPlayer.setVolume value

do (document, window) ->

  dz = new DeezerController()

  # Overiding console.warn to stop warnings from Facebook's
  # postMessage usage.
  # This is a temporary solution until I or someone else find
  # something fancy.
  console.warn = ->
    return

  # Getting the message sent by the controller and taking the action
  window.addEventListener "message", (event) ->
    if event.source != window
      return
    if event.data.type? and event.data.type is "deezer-controller"
      if event.data.cod?
        switch event.data.cod
          when 1 then dz.play()
          when 0 then dz.pause()


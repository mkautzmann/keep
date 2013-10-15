# YouTube Monitor = Injected in YT web page

# youtubeController must be global as well

youtubeController = null

# This has to be global so YouTube player can find it
stateChanged = (state) ->
  youtubeController.state = state
  switch state
    when 1 then youtubeController.stopOther()
    when 0, 2, 3 then youtubeController.playOther()

# Utility companion class, so far it just fixes typeof
class Util

  @typeOf: (object) ->
    classTypes =
      "[object String]": "string"
      "[object Array]": "array"
      "[object Null]": "null"
      "[object Number]": "number"
      "[object RegExp]": "regexp"
      "[object Date]": "date"
      "[object Boolean]": "boolean"
      "[object Function]": "function"
      "[object Error]": "error"
      "[object Undefined]": "undefined"

    #Using object's prototype to see what type is object
    typeString = Object::toString.call(object)
    return classTypes[typeString] or "object"

# YouTubeController class, that controls the YT player
# Works with Flash and HTML5 players
class YouTubeController

  state: null

  constructor: (@id, @playFunc, @stopFunc) ->
    @state = 0
    @setPlayer()
    @preparePlayer()

  getPlayer: ->
    return @player

  setPlayer: ->
    if Util.typeOf(@id) is "string"
      @player = document.getElementById @id
    if not @player?
      setTimeout setPlayer, 500

  preparePlayer: ->
    if @player?
      @setStateListener()
    else
      throw new Error "YouTube player not available"

  setStateListener: ->
    @player.addEventListener("onStateChange", "stateChanged")

  stopOther: ->
    if @stopFunc?
      @stopFunc.apply()

  playOther: ->
    if @playFunc?
      @playFunc.apply()

  getState: ->
    @state = @player.getPlayerState()
    return @state

  setVolume: (value) ->
    if Util.typeOf(value) is "number" and 0 <= value <= 100
      @player.setVolume(value)

  getVolume: ->
    return @player.getVolume()

do (document, window) ->
  # Telling controller that YouTube stopped, so play deezer
  playDeezer = ->
    window.postMessage
      type: "youtube-controller"
      cod: 1
    , "http://www.youtube.com/"
  # Telling controller that YouTube is playing, so stop deezer
  stopDeezer = ->
    window.postMessage
      type: "youtube-controller"
      cod: 0
    , "http://www.youtube.com/"

  # Initializing YouTube wrapper
  youtubeController = new YouTubeController "movie_player",
   playDeezer, stopDeezer



gameLolWut = (PONG) ->
  bp = PONG.BALL.position()
  p1p = PONG.P1.position()
  p2p = PONG.P2.position()
  if bp.top < 0
    PONG.BALLY = PONG.BALLSPEED
  else PONG.BALLY = -PONG.BALLSPEED  if bp.top + PONG.BALLHEIGHT > PONG.WINDOWHEIGHT
  if bp.left < 0
    PONG.p2Score += 1
    PONG.P2.text PONG.p2Score.toString()
    PONG.RANDOMBALLGO()
  else if bp.left + PONG.BALLWIDTH > PONG.WINDOWWIDTH
    PONG.p1Score += 1
    PONG.P1.text PONG.p1Score.toString()
    PONG.RANDOMBALLGO()
  else if bp.left < PONG.PADDLEMARGIN + PONG.PADDLEWIDTH
    if bp.top + PONG.BALLHEIGHT > p1p.top and bp.top < p1p.top + PONG.PADDLEHEIGHT
      PONG.BALLX = PONG.BALLSPEED
      if PONG.P1UP
        PONG.BALLY = -PONG.BALLSPEED
      else PONG.BALLY = PONG.BALLSPEED  if PONG.P1DOWN
  else if bp.left > p2p.left
    if bp.top + PONG.BALLHEIGHT > p2p.top and bp.top < p2p.top + PONG.PADDLEHEIGHT
      PONG.BALLX = -PONG.BALLSPEED
      if PONG.P2UP
        PONG.BALLY = -PONG.BALLSPEED
      else PONG.BALLY = PONG.BALLSPEED  if PONG.P2DOWN
  PONG.BALL.stop()
  PONG.P1.stop()
  PONG.P2.stop()
  PONG.BALL.animate
    left: "+=" + PONG.BALLX + "px"
    top: "+=" + PONG.BALLY + "px"
  , PONG.DELTATIME
  if PONG.P1UP
    PONG.P1.animate
      top: "-=" + PONG.PADDLESPEED
    , PONG.DELTATIME
  else if PONG.P1DOWN
    PONG.P1.animate
      top: "+=" + PONG.PADDLESPEED
    , PONG.DELTATIME
  if PONG.P2UP
    PONG.P2.animate
      top: "-=" + PONG.PADDLESPEED
    , PONG.DELTATIME
  else if PONG.P2DOWN
    PONG.P2.animate
      top: "+=" + PONG.PADDLESPEED
    , PONG.DELTATIME
  window.setTimeout game, PONG.DELTATIME

doPONG = ->
  PONG.P1 = $(document.createElement("p"))
  PONG.P2 = $(document.createElement("p"))

  paddleSettings =
    #addClass is better for the static values
    position: "fixed"
    width: PONG.PADDLEWIDTH + "px"
    height: PONG.PADDLEHEIGHT + "px"
    left: PONG.PADDLEMARGIN + "px"
    top: PONG.WINDOWHEIGHT / 2 - PONG.PADDLEHEIGHT / 2 + "px"
    backgroundColor: "white"
    border: "2px solid black"
    textAlign: "center"
    verticalAlign: "middle"

  PONG.P1.css paddleSettings

  PONG.P2.css $.extend paddleSettings,
    left: PONG.WINDOWWIDTH - PONG.PADDLEWIDTH - PONG.PADDLEMARGIN + "px"

  keyMappings =
    Q: PONG.P1UP
    A: PONG.P1DOWN
    P: PONG.P2UP
    L: PONG.P2DOWN

  $(document).on "keydown", (event) ->
    keyMappings[String.fromCharCode(event.which)] = true
  $(document).on "keyup", (event) ->
    keyMappings[String.fromCharCode(event.which)] = false


  PONG.BALL = $(document.createElement("p")).css
    position: "fixed"
    width: PONG.BALLWIDTH
    height: PONG.BALLHEIGHT
    backgroundColor: "white"
    border: "2px solid black"

  background = $(document.createElement("p"))
    .css
      position: "fixed"
      top: "0px"
      left: "0px"
      backgroundColor: "black"
      width: PONG.WINDOWWIDTH + "px"
      height: PONG.WINDOWHEIGHT + "px"
    .append PONG.P1
    .append PONG.P2
    .append PONG.BALL

  $("body").append background
  #this whole thing above is silly

  PONG.RANDOMBALLGO()

  game = ->
    gameLolWut(PONG)
  window.setTimeout game, PONG.DELTATIME

gHandler = (event) ->
  if String.fromCharCode(event.which) is "g"
    unless G?
      G = true
      $(document).off "keypress", pHandler
      doPONG()

# timeoutKeyHandler = (e, letter) ->
#   if String.fromCharCode(e.which) == letter && !keyPressTimeout
#     keyPressTimeout = window.setTimeout(->
#       $(document).off "keypress", timeoutKeyHandler(letter)
#       keyPressTimeout = null
#       , 500)
#     $(document).on 'keypress', timeoutKeyHandler(letter)
# I don't even know what's happening with these timeouts, and why does each 'letter'
# handler reference another handler? (g -> n, o -> n, etc)
# there's a bunch of duplication here that's ripe for cleanup

nHandler = (event) ->
  if String.fromCharCode(event.which) is "n"
    unless N?
      N = window.setTimeout(->
        $(document).off "keypress", gHandler
        N = null
      , 500)
      $(document).on "keypress", gHandler

oHandler = (event) ->
  if String.fromCharCode(event.which) is "o"
    unless O?
      O = window.setTimeout(->
        $(document).off "keypress", nHandler
        O = null
      , 500)
      $(document).on "keypress", nHandler

pHandler = (event) ->
  if String.fromCharCode(event.which) is "p"
    unless P?
      P = window.setTimeout(->
        $(document).off "keypress", oHandler
        P = null
      , 500)
      $(document).on "keypress", oHandler

P = O = N = G = null

PONG =
  P1UP: false, P1DOWN: false
  P2UP: false, P2DOWN: false
  P1: null   , P2: null
  PADDLEWIDTH: 25
  PADDLEHEIGHT: 100
  PADDLESPEED: 16
  PADDLEMARGIN: 20
  BALL: null
  BALLWIDTH: 15
  BALLHEIGHT: 15
  BALLSPEED: 15
  BALLX: 0
  BALLY: 0
  p1Score: 0  , p2Score: 0

  RANDOMBALLGO: ->
    PONG.BALL.css
      left: PONG.WINDOWWIDTH / 2 - PONG.BALLWIDTH / 2 + "px"
      top: PONG.WINDOWHEIGHT / 2 - PONG.BALLHEIGHT / 2 + "px"

    if Math.random() < 0.5
      PONG.BALLX = -PONG.BALLSPEED
      PONG.BALLY = PONG.BALLSPEED
    else
      PONG.BALLX = PONG.BALLSPEED
      PONG.BALLY = -PONG.BALLSPEED

  WINDOWWIDTH: 900
  WINDOWHEIGHT: 600
  DELTATIME: 20

$(document).ready ->
  $(document).on "keypress", pHandler

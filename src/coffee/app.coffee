window.$ = $ = require 'jquery'
aware = require 'aware'

_ = require 'lodash'

current = 
  tick     : 0
  progres  : 0
  playhead : 0
  last_tick: 0
  average  : 10
  history  : []

notes = aware {}

template = require '../jade/app'

$ ->

  $( 'body' ).html template()

  # world = require './threed/world'

  socket = io.connect('http://localhost:1337')

  next = ( tick ) ->

      current.progress = current.tick / 96

      current.playhead = current.progress % 1
      current.playhead = Number current.playhead.toFixed(2)

      # console.log 'progress ->', current.progress

      current.tick++

  # every clock tick
  tick = ->

    ms = performance.now() - current.last_tick

    if current.tick
      current.history.push ms

      # console.log current.history

      if current.history.length > current.average
        current.history = current.history.splice(-current.average)

      ms = current.history.reduce (sum, num) -> return sum + num

      ms = ms / current.history.length

      # console.log 'reduced ->', ms

      # console.log "ms ->", ms
      PPQ = 96

      BPM = 60000 / ( ms * 24 )
      # BPM = BPM.toFixed 2

      $( '.bpm' ).html( "bpm: #{BPM}" )

    current.last_tick = performance.now()

    if current.playhead == 0

      $( '.square' ).css 'left', 0

      # console.info "~ ty : #{current.playhead}"
      return

    if current.playhead == 0.25

      $( '.square' ).css 'left', 20

      # console.log "~ tu : #{current.playhead}"
      return

    if current.playhead == 0.5

      $( '.square' ).css 'left', 40

      # console.log "~ tu : #{current.playhead}"
      return

    if current.playhead == 0.75

      $( '.square' ).css 'left', 60

      # console.log "~ tu : #{current.playhead}"
      return

  print_message = ( message ) ->
    console.log "got message ->",
      type  : message[0]
      number: message[1]
      value : message[2]

  socket.on 'message', ( data )->

    message = data.message

    type   = message[0]
    number = message[1]
    value  = message[2]

    # ~ note off
    if type is 128 then return notes.set number, 0

    # ~ note on
    if type is 144

      print_message( message )

      return notes.set number, value

    # ~ start
    if type is 250

      current.tick    = 0
      current.history = []

      return next()

    # ~ clock tick
    if type is 248 then tick(); return next()

  notes.on '65', ( value ) ->


    if value
      $( 'body' ).css 'background', 'yellow'

    # if value is 0
    #   console.log "OFF"

  notes.on '66', ( value ) ->


    if value
      $( 'body' ).css 'background', 'purple'

    # if value is 0
    #   console.log "OFF"

  notes.on '67', ( value ) ->


    if value
      $( 'body' ).css 'background', 'white'

    # if value is 0
    #   console.log "OFF"

  notes.on '68', ( value ) ->


    if value
      $( 'body' ).css 'background', 'cyan'

    # if value is 0
    #   console.log "OFF"

  notes.on '68', ( value ) ->


    if value
      $( 'body' ).css 'background', 'green'

    # if value is 0
    #   console.log "OFF"

  notes.on '69', ( value ) ->


    if value
      $( 'body' ).css 'background', 'blue'

    # if value is 0
    #   console.log "OFF"

  notes.on '70', ( value ) ->


    if value
      $( 'body' ).css 'background', 'red'

    # if value is 0
    #   console.log "OFF"
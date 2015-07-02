root = exports ? this

addlog = (text) ->
  console.log text
  $('<div>').text(text).appendTo('#results')

mkrecognition = ->
  root.recognition = recognition = new webkitSpeechRecognition()
  recognition.lang = 'en-US'
  recognition.continuous = false
  recognition.interimResults = false
  recognition.maxAlternatives = 5
  recognition.onresult = (event) ->
    addlog event
    addlog event.results.length
    addlog event.results[0].length
    #addlog event.results[0][0].transcript
    for x in event.results[0]
      addlog (x.transcript + '|' + x.confidence)
    if event.results[0].isFinal
      addlog 'done'
      recognition.stop()
      $('#startbutton').text('Press me')
  return recognition

$(document).ready ->
  recognition = mkrecognition()
  $('#startbutton').click ->
    console.log 'started!'
    $('#startbutton').text('Recording')
    recognition.start()

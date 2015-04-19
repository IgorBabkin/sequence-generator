#= require jquery.console

$ ->
  class SequenceConsole
    min: 0
    max: 21

    options: ->
      promptLabel: 'Enter number between 1 and 21 > '
      commandValidate: (line)=> @validate(line)
      commandHandle: (line, report)=> @handler(line, report)
      animateScroll: true
      promptHistory: true

    constructor: (element)->
      $(element).console @options()

    validate: (line)->
      number = parseInt(line)
      return false if isNaN(number)
      return false unless @max > number > @min
      true

    handler: (line, report)->
      number = parseInt(line)
      @requestSequence(number).success (data)-> report(data.join("\n"))
      return

    requestSequence: (number)->
      $.getJSON('/generate', size: number)

  new SequenceConsole('.js-terminal')
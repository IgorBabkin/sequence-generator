#= require jquery.terminal/js/jquery.terminal-src.js

$ ->
  class SequenceTerminal
    min: 0
    max: 21
    options:
      greetings: 'Enter length of sequence, please!'
      height: 300
      prompt: 'Enter number between 1 and 21 > '

    constructor: (element)->
      handler = (command, @term)=> @handler(command)
      $(element).terminal handler, @options

    is_valid: (number)->
      return false if isNaN(number)
      return false unless @max > number > @min
      true

    handler: (command)->
      number = parseInt(command)
      return false unless @is_valid number
      @requestSequence(number).success (data)=> @display(data)
      false

    requestSequence: (number)->
      $.getJSON('/generate', size: number)

    display: (response)->
      @term.echo response.join("\n")

  new SequenceTerminal('.js-terminal')
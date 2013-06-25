###
   Class UiEvents : used to declare generic events related to the UI
###

class @UiEvents
  @init = ->
        
    $(document).off 'click', '.flash'
    $(document).on 'click', '.flash', (e) ->
      $(this).hide()


$(document).ready ->
  UiEvents.init()

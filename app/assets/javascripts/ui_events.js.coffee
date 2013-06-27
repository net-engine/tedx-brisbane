###
   Class UiEvents : used to declare generic events related to the UI
###

class @UiEvents
  @init = ->
    @resizeUI()

    $(document).off 'click', '.flash'
    $(document).on 'click', '.flash', (e) ->
      $(this).hide()
  
  @resizeUI: ->
    $('.header, .main').css('min-height', $(window).height())
    $(window).resize -> $('.header, .main').css('min-height', $(window).height())

$(document).ready ->
  UiEvents.init()

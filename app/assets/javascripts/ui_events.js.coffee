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


  if $('#new_attendee').length
    $('#attendee_tweet_idea').on 'keyup', (e) ->
      count = 140 - $(this).val().length

      $('#char_count').html(count)

      if count < 10
        $('#char_count').addClass('limit')
      else
        $('#char_count').removeClass('limit')


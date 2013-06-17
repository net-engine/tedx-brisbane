$ ->
  if $('#attendee-statistics').length > 0
    subscribeToRealtimeStatistics()
    $.getJSON "/api/v1/attendees/statistics.json", (data) ->
      updateStatistics(data)

updateStatistics = (data) ->
  html = HandlebarsTemplates['attendee_statistics'](data.attendee_statistics)
  $('#attendee-statistics').html(html)

subscribeToRealtimeStatistics = ->
  pusher().subscribe(statisticsChannel()).bind 'update', (data) ->
    updateStatistics(data)

statisticsChannel = ->
  $('#attendee-statistics').data('channel')

pusherKey = ->
  $('#pusher-key').data('pusher-key')

pusher = ->
  new Pusher(pusherKey())

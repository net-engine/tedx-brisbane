$ ->
  $.getJSON "/api/v1/attendees/statistics.json", (data) ->
    append_statistics(data.attendee_statistics)

append_statistics = (data) ->
  html = HandlebarsTemplates['attendee_statistics'](data)
  $('body').append(html)

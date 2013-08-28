$(document).on 'submit', '#new_payment', (e) ->
  $('.submit-container').spin('small', 'white')
  $('.submit-container .btn').val('')

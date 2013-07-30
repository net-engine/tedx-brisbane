class PaymentStudentHandler
  constructor : ->
    @$studentSelect = $('#student_amount')
    @$trData        = $('#tr_data')
    @trDataNormal   = $('#tr_data_normal').val()
    @trDataStudent  = $('#tr_data_student').val()

  bindChanges : ->
    @$studentSelect.off('change')
    @$studentSelect.on 'change', =>
      @updateTrData()

  isStudent : ->
    return JSON.parse(@$studentSelect.val())

  updateTrData : ->
    if @isStudent()
      @$trData.val(@trDataStudent)
      @$studentSelect.after('<p class="student-helper-message">Students must present photo ID.</p>')
    else
      @$trData.val(@trDataNormal)
      $('.student-helper-message').remove()


$ ->
  if $('#student_amount').length > 0
    psh = new PaymentStudentHandler()
    psh.bindChanges()

$(document).on 'submit', '#new_payment', (e) ->
  $('.submit-container').spin('small', 'white')
  $('.submit-container .btn').val('')

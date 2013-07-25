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
    else
      @$trData.val(@trDataNormal)


$ ->
  if $('#student_amount').length > 0
    psh = new PaymentStudentHandler()
    psh.bindChanges()

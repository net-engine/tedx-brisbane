class @SubmissionFormHandler
  constructor: (@$toggleButton, @$form) ->
    @displayForm() if @needToDisplayForm()

  bindClickOnToggle: ->
    @$toggleButton.off('click');
    @$toggleButton.on 'click', =>
      @displayForm()

  displayForm: ->
    @$toggleButton.hide()
    @$form.fadeIn()

  needToDisplayForm: ->
    @$form.find('#attendee_first_name').val() != "" ||
      @$form.find('#attendee_last_name').val() != "" ||
      @$form.find('#attendee_email_address').val() != ""

  validate: ->
    @$form.validate({
    onkeyup: (element) -> $(element).valid(),
    rules: {
        "attendee[first_name]": "required",
        "attendee[last_name]": "required",
        "attendee[email_address]": {
          required: true,
          email: true
        },
      },
      messages: {
        "attendee[first_name]": "Please enter your firstname",
        "attendee[last_name]": "Please enter your lastname",
        "attendee[email_address]": {
          required: "Please enter your email",
          email: "Please enter a valid email address"
        }
      }
    });

$ ->
  if ($("#new_attendee").length > 0)
    form = new SubmissionFormHandler($("#toggle-button"), $("#new_attendee"))
    form.bindClickOnToggle()
    form.validate()
class @SubmissionFormHandler
  constructor: (@$form) ->

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
    form = new SubmissionFormHandler($("#new_attendee"))
    form.validate()
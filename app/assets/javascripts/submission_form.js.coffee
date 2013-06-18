class SubmissionFormHandler

	constructor: (@$toggleButton, @$attendeeForm) ->
		@displayForm() if @shouldDisplayForm()

	bindClickToggleButton: ->
		@$toggleButton.off('click')
		@$toggleButton.on 'click', =>
			@displayForm()

	displayForm: ->
		@$toggleButton.hide()
		@$attendeeForm.fadeIn()

	shouldDisplayForm: ->
		@$attendeeForm.find('#attendee_first_name').val() != "" ||
			@$attendeeForm.find('#attendee_last_name').val() != "" ||
			@$attendeeForm.find('#attendee_email_address').val() != ""


$ ->
	if $('#toggle-button').length > 0
		form = new SubmissionFormHandler($('#toggle-button'), $('#new_attendee'))
		form.bindClickToggleButton()



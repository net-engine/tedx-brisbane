#= require spec_helper
#= require jquery.validate
#= require submission_form_handler

attendee = (first_name, last_name, email_address) ->
  {
    first_name      : first_name,
    last_name       : last_name,
    email_address   : email_address
  }

describe "Submission Form Handler", ->

  describe "Init form when rendering an empty attendee", ->
    beforeEach ->
      $("body").append(HandlebarsTemplates["submission_form"](attendee("","","")))
      form = new SubmissionFormHandler($("#toggle-button"), $("#new_attendee"))
      form.bindClickOnToggle()
      form.validate()

    it "does not display the form", ->
      expect($("#new_attendee").is(":visible")).to.be.false

  describe "Init form when rendering a non empty attendee", ->
    beforeEach ->
      $("body").append(HandlebarsTemplates["submission_form"](attendee("Dan","Sowter","dan@netengine.com.au")))
      form = new SubmissionFormHandler($("#toggle-button"), $("#new_attendee"))
      form.bindClickOnToggle()
      form.validate()

    it "displays the form", ->
      expect($("#new_attendee").is(":visible")).to.be.true


  describe "Clicking on the toggle button displays the attendee form", ->
    beforeEach ->
      $("body").append(HandlebarsTemplates["submission_form"](attendee("","","")))
      form = new SubmissionFormHandler($("#toggle-button"), $("#new_attendee"))
      form.bindClickOnToggle()
      form.validate()

    it "displays the form", ->
      expect($("#new_attendee").is(":visible")).to.be.false
      $("#toggle-button").click()
      expect($("#new_attendee").is(":visible")).to.be.true


  describe "When submitting an empty attendee", ->
    beforeEach ->
      $("body").append(HandlebarsTemplates["submission_form"](attendee("","","")))
      form = new SubmissionFormHandler($("#toggle-button"), $("#new_attendee"))
      form.bindClickOnToggle()
      form.validate()
      $("#toggle-button").click()

    it "displays the form errors", ->
      $("#submit").click()
      $("#attendee_first_name").siblings(".error").text().should.equal("Please enter your firstname")
      $("#attendee_last_name").siblings(".error").text().should.equal("Please enter your lastname")
      $("#attendee_email_address").siblings(".error").text().should.equal("Please enter your email")


  describe "Onkey up with an empty attendee", ->
    beforeEach ->
      $("body").append(HandlebarsTemplates["submission_form"](attendee("","","")))
      form = new SubmissionFormHandler($("#toggle-button"), $("#new_attendee"))
      form.bindClickOnToggle()
      form.validate()
      $("#toggle-button").click()

    it "displays the form errors", ->
      $("#attendee_first_name").keyup()
      $("#attendee_last_name").keyup()
      $("#attendee_email_address").keyup()
      $("#attendee_first_name").siblings(".error").text().should.equal("Please enter your firstname")
      $("#attendee_last_name").siblings(".error").text().should.equal("Please enter your lastname")
      $("#attendee_email_address").siblings(".error").text().should.equal("Please enter your email")


  describe "Onkey up with an incorrect email", ->
    beforeEach ->
      $("body").append(HandlebarsTemplates["submission_form"](attendee("","","dandan")))
      form = new SubmissionFormHandler($("#toggle-button"), $("#new_attendee"))
      form.bindClickOnToggle()
      form.validate()
      $("#toggle-button").click()

    it "displays the proper error message", ->
      $("#attendee_email_address").keyup()
      $("#attendee_email_address").siblings(".error").text().should.equal("Please enter a valid email address2")
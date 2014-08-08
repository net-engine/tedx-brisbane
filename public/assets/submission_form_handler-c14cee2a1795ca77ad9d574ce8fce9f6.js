(function() {
  this.SubmissionFormHandler = (function() {
    function SubmissionFormHandler($form) {
      this.$form = $form;
    }

    SubmissionFormHandler.prototype.validate = function() {
      var messages, onkeyup, rules;
      onkeyup = function(element) {
        return $(element).valid();
      };
      rules = {
        "attendee[first_name]": "required",
        "attendee[last_name]": "required",
        "attendee[email_address]": {
          required: true,
          email: true
        }
      };
      messages = {
        "attendee[first_name]": "Please enter your firstname",
        "attendee[last_name]": "Please enter your lastname",
        "attendee[email_address]": {
          required: "Please enter your email",
          email: "Please enter a valid email address"
        }
      };
      return this.$form.validate({
        onkeyup: onkeyup,
        rules: rules,
        messages: messages
      });
    };

    return SubmissionFormHandler;

  })();

  $(function() {
    var form;
    if ($("#new_attendee").length > 0) {
      form = new SubmissionFormHandler($("#new_attendee"));
      return form.validate();
    }
  });

  $(document).on('submit', '#new_attendee', function(e) {
    e.preventDefault();
    $('.submit-container').spin('small', 'white');
    return $('#submit').val('');
  });

  $(document).ajaxStop(function() {
    $('.submit-container').spin(false);
    return $('#submit').val('Register');
  });

}).call(this);

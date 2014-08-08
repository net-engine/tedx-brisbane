(function() {
  var PaymentFormHandler;

  PaymentFormHandler = (function() {
    function PaymentFormHandler($form) {
      this.$form = $form;
      this.$submit = this.$form.find('.submit-container');
    }

    PaymentFormHandler.prototype.bindSubmitAction = function() {
      this.$submit.off('click');
      return this.$submit.on('click', (function(_this) {
        return function(e) {
          _this.$submit.spin('small', 'white');
          return _this.$submit.find('.btn').val('');
        };
      })(this));
    };

    PaymentFormHandler.prototype.validate = function() {
      return this.$form.validate({
        onkeyup: function(element) {
          return $(element).valid();
        },
        rules: {
          "transaction[customer][first_name]": "required",
          "transaction[customer][last_name]": "required",
          "transaction[credit_card][type]": "required",
          "transaction[credit_card][number]": "required",
          "transaction[credit_card][expiration_date]": "required",
          "transaction[credit_card][cvv]": "required"
        },
        messages: {
          "transaction[customer][first_name]": "Please enter the first name as it appears in your credit card",
          "transaction[customer][last_name]": "Please enter the last name as it appears in your credit card",
          "transaction[credit_card][type]": "Please select your credit card brand",
          "transaction[credit_card][number]": "Please fill in your credit card number",
          "transaction[credit_card][expiration_date]": "Please fill in your credit card expiration date",
          "transaction[credit_card][cvv]": "Please fill in your credit card security code"
        },
        invalidHandler: (function(_this) {
          return function(form, validator) {
            _this.$submit.spin(false);
            return _this.$submit.find('.btn').val('Submit');
          };
        })(this)
      });
    };

    return PaymentFormHandler;

  })();

  $(function() {
    var pfh;
    if ($('#new_payment').length) {
      pfh = new PaymentFormHandler($('#new_payment'));
      pfh.bindSubmitAction();
      return pfh.validate();
    }
  });

}).call(this);

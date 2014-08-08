
/*
   Class UiEvents : used to declare generic events related to the UI
 */

(function() {
  this.UiEvents = (function() {
    function UiEvents() {}

    UiEvents.init = function() {
      this.resizeUI();
      $(document).off('click', '.flash');
      return $(document).on('click', '.flash', function(e) {
        return $(this).hide();
      });
    };

    UiEvents.resizeUI = function() {
      $('.header, .main').css('min-height', $(window).height());
      return $(window).resize(function() {
        return $('.header, .main').css('min-height', $(window).height());
      });
    };

    return UiEvents;

  })();

  $(document).ready(function() {
    UiEvents.init();
    if ($('#new_attendee').length) {
      return $('#attendee_tweet_idea').on('keyup', function(e) {
        var count;
        count = 140 - $(this).val().length;
        $('#char_count').html(count);
        if (count < 10) {
          return $('#char_count').addClass('limit');
        } else {
          return $('#char_count').removeClass('limit');
        }
      });
    }
  });

}).call(this);

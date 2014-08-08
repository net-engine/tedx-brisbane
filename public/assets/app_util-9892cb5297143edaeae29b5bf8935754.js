
/*
   Class AppUtil : used to embed static methods not related to the UI
   and used throughout the application
 */

(function() {
  this.AppUtil = (function() {
    function AppUtil() {}

    AppUtil.setupAjax = function() {
      return $.ajaxSetup({
        beforeSend: function(xhr) {
          return xhr.setRequestHeader("AUTHORIZATION", "Token token=" + AppUtil.apiToken());
        }
      });
    };

    AppUtil.apiToken = function() {
      return $('[data-api-token]').data('api-token');
    };

    return AppUtil;

  })();

  $(document).ready(function() {
    return AppUtil.setupAjax();
  });

}).call(this);

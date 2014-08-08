(function() {
  var pusher, pusherKey, statisticsChannel, subscribeToRealtimeStatistics, updateStatistics;

  $(function() {
    if ($('#attendee-statistics').length > 0) {
      subscribeToRealtimeStatistics();
      return $.getJSON("/api/v1/attendees/statistics.json", function(data) {
        return updateStatistics(data);
      });
    }
  });

  updateStatistics = function(data) {
    var html;
    html = HandlebarsTemplates['attendee_statistics'](data.attendee_statistics);
    return $('#attendee-statistics').html(html);
  };

  subscribeToRealtimeStatistics = function() {
    return pusher().subscribe(statisticsChannel()).bind('update', function(data) {
      return updateStatistics(data);
    });
  };

  statisticsChannel = function() {
    return $('#attendee-statistics').data('channel');
  };

  pusherKey = function() {
    return $('#pusher-key').data('pusher-key');
  };

  pusher = function() {
    return new Pusher(pusherKey());
  };

}).call(this);

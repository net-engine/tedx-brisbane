(function() {
  this.HandlebarsTemplates || (this.HandlebarsTemplates = {});
  this.HandlebarsTemplates["submission_form"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, helper, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<button class=\"btn\" id=\"toggle-button\" name=\"button\" type=\"submit\">Attend!</button>\n<form accept-charset=\"UTF-8\" action=\"/attendees\" class=\"new_attendee\" id=\"new_attendee\" method=\"post\" novalidate=\"novalidate\"><div style=\"margin:0;padding:0;display:inline\"><input name=\"utf8\" type=\"hidden\" value=\"✓\"><input name=\"authenticity_token\" type=\"hidden\" value=\"Q7me44JeOlyGNhsLg3koXhptobB0TdM81Izwmso45Ro=\"></div>  <section id=\"inputs\">\n    <ol>\n      <li>\n        <label for=\"attendee_first_name\">First name</label>\n        <input id=\"attendee_first_name\" name=\"attendee[first_name]\" type=\"text\" value=\"";
  if (helper = helpers.first_name) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.first_name); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "\">\n      </li>\n      <li>\n        <label for=\"attendee_last_name\">Last name</label>\n        <input id=\"attendee_last_name\" name=\"attendee[last_name]\" type=\"text\" value=\"";
  if (helper = helpers.last_name) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.last_name); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "\">\n      </li>\n      <li>\n        <label for=\"attendee_email_address\">Email address</label>\n        <input id=\"attendee_email_address\" name=\"attendee[email_address]\" type=\"email\" value=\"";
  if (helper = helpers.email_address) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.email_address); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "\">\n      </li>\n    </ol>\n  </section>\n  <section id=\"buttons\">\n    <ol>\n      <li>\n        <a href=\"/\">Cancel</a>\n        <input class=\"btn\" id=\"submit\" name=\"commit\" type=\"submit\" value=\"Attend!\">\n      </li>\n    </ol>\n  </section>\n</form>";
  return buffer;
  });
  return this.HandlebarsTemplates["submission_form"];
}).call(this);

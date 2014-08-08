(function() {
  this.HandlebarsTemplates || (this.HandlebarsTemplates = {});
  this.HandlebarsTemplates["attendee_statistics"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, helper, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<ul>\n  <li id=\"awaiting_invitation\">\n    <label>Awaiting Invitation</label>\n    <p>";
  if (helper = helpers.awaiting_invitation) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.awaiting_invitation); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "</p>\n  </li>\n\n  <li id=\"received_invitation\">\n    <label>Received Invitation</label>\n    <p>";
  if (helper = helpers.received_invitation) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.received_invitation); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "</p>\n  </li>\n\n  <li id=\"declined\">\n    <label>Declined</label>\n    <p>";
  if (helper = helpers.declined) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.declined); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "</p>\n  </li>\n\n  <li id=\"paid\">\n    <label>Paid</label>\n    <p>";
  if (helper = helpers.paid) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.paid); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "</p>\n  </li>\n\n  <li id=\"received_reminder\">\n    <label>Received Reminder</label>\n    <p>";
  if (helper = helpers.received_reminder) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.received_reminder); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "</p>\n  </li>\n\n  <li id=\"confirmed\">\n    <label>Confirmed</label>\n    <p>";
  if (helper = helpers.confirmed) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.confirmed); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "</p>\n  </li>\n</ul>";
  return buffer;
  });
  return this.HandlebarsTemplates["attendee_statistics"];
}).call(this);

// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var add_fields = function(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).prev().append(content.replace(regexp, new_id));
}

var remove_fields = function(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".togglable").hide();
}

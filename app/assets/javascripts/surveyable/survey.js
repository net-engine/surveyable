var add_fields, question_type, remove_fields;

add_fields = function(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).prev().append(content.replace(regexp, new_id));
};

remove_fields = function(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".togglable").hide();
};

question_type = function() {
  $('.question_field_type_select').change(function(e) {
    var $this = $(this)
    var field = $this.closest('.question_field')

    field.removeClass();
    field.addClass( "question_field " + $this.find('option:selected').val() );
  });
};

$(document).ready(function() {
  question_type();
  $('.survey_date').datepicker()
});

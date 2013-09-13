(function(w){
  var add_fields = function(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(content.replace(regexp, new_id)).insertBefore(link);
    reorderQuestionPosition();
  };

  var remove_fields = function(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".togglable").remove();
    reorderQuestionPosition();
  };

  var resetAnswers = function($field){
    $("input.answer-content", $field).each(function(){ $(this).val("") });
  }

  var autoAppendAnswer = function(){
    $(document).on("keyup", "input.answer-content", function(){
      var $parent = $(this).closest(".question_field");
      if ($(this)[0] == $("input.answer-content", $parent).last()[0]) {
        $parent.find(".add-answers-link").click();
      }
    });
  }

  var bindQuestionTypeChanges = function(){
    $(document).on('change', '.question_field_type_select', function(e) {
      var $this = $(this);
      var $field = $this.closest('.question_field');
      var field_type = $this.find('option:selected').val()
      var reset_types = ["text_area_field", "text_field", "date_field", "rank_field"]
      
      if ($.inArray( field_type, reset_types) != -1 ) {
        resetAnswers($field);
      }
      
      $field.removeAttr('class');
      $field.addClass("question_field togglable " + field_type);
    });
  };

  var reorderQuestionPosition = function(){
    $(".question-position").each(function(index) {
      $(this).val(index);
    });
  };

  var reorderAnswerPosition = function(){
    $(".question_field").each(function() {
      $(this).find(".answer-position").each(function(index){
        $(this).val(index);
      });
    });
  };

  var makeMovableQuestions = function(){
    $('.questions_list').sortable({
      items: '.question_field',
      containment: 'parent',
      handle: '.handle',
      axis: 'y',
      tolerance: "pointer",
      update: function(){
        reorderQuestionPosition();
      }
    });
  };

  var makeMovableAnswers = function(){
    $('.answers_list').sortable({
      items: '.anwser_field',
      containment: 'parent',
      handle: '.handle',
      axis: 'y',
      tolerance: "pointer",
      update: function(){
        reorderAnswerPosition();
      }
    });
  };

  $(document).ready(function(){
    var $questionFieldType = $(".question_field_type_select");
    if ($questionFieldType.length > 0){
      bindQuestionTypeChanges();
      $questionFieldType.trigger('change');

      // in case of a new survey, provide a position to each questions and answers
      reorderQuestionPosition();
      reorderAnswerPosition();

      makeMovableQuestions();
      makeMovableAnswers();

      autoAppendAnswer();
    }
  });

  // exporting global methods
  w.add_fields    = add_fields;
  w.remove_fields = remove_fields;
})(window);

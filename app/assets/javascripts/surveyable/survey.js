(function(w){
  var add_fields = function(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).prev().append(content.replace(regexp, new_id));
    reorderQuestionPosition();
  };

  var remove_fields = function(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".togglable").hide();
    reorderQuestionPosition();
  };

  var bindQuestionTypeChanges = function(){
    $(document).on('change', '.question_field_type_select', function(e) {
      var $this = $(this);
      var $field = $this.closest('.question_field');

      $field.removeAttr('class');
      $field.addClass("question_field togglable " + $this.find('option:selected').val());
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
      start: function(event, ui) {
        $(this).addClass('dragging');
      },
      stop: function(event, ui) {
        $(this).removeClass('dragging');
      },
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
    }
  });

  // exporting global methods
  w.add_fields    = add_fields;
  w.remove_fields = remove_fields;
})(window);

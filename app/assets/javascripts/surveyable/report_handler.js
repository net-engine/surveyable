(function(w){

  var drawGraph = function(type, data, $element, options) {
    var defaults = {
      element: $element,
      data: data
    }

    var final_options = $.extend(defaults, options);

    var graph = new Morris[type](final_options);

    window.onresize = function() {
      window.setTimeout(function(){
        graph.redraw()
      }, 500);
    }
  }

  $(document).ready(function(){
    var $reportableQuestion = $(".reportable_question");
    if ($reportableQuestion.length > 0){
      $reportableQuestion.each(function( index ){
        var $element = $(this).closest('.question').find('.graph');
        
        $.ajax({
          url: "/surveyable/questions/"+$(this).val()+"/reports",
          dataType: "json",
          success: function(results){
            var type, options, data;

            if (results.field_type == "check_box_field") {
              data = results.answers;
              type = "Bar";
              options = {
                xkey: 'answer_text',
                ykeys: ['answer_occurrence'],
                labels: ['Answer Occurrence']
              }

            } else if (results.field_type == "rank_field") {
              data = results.answers;
              type = "Line";
              options = {
                xkey: 'answer_text',
                ykeys: ['Answer Occurrence'],
                labels: ['Value']
              }
            
            } else if (results.field_type == "radio_button_field") {
              type = "Donut"
              data = $.map(results.answers, function(answer, index){
                return { value: answer.answer_occurrence, label: answer.answer_text };
              });
            }

            drawGraph(type, data, $element, options);
          }
        });
      });
    }
  });
})(window);

(function(w){

  var drawGraph = function(type, data, $element) {
    var graph = new Morris[type] {
      element: $element,
      data: data,
      hideHover: 'auto',
      fillOpacity: 0.2,
      grid: false,
    }

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
        var $element = $(this).closest('.question').find('.chart');
        $.ajax({
          url: "/surveyable/questions/"+$(this).val()+"/reports",
          dataType: "json",
          success: function(results){
            drawGraph(results.type, results.questions, $element);
          }
        });
      });
    }
  });
})(window);

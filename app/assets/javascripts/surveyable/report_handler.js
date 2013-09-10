var Surveyable = function(){

  var self = this, drawGraph, barRequired, lineRequired;

  barRequired = {
    xkey: 'answer_text',
    ykeys: ['answer_occurrence'],
    labels: ['Answer Occurrence'],
    xLabelAngle: 35
  }

  lineRequired = {
    xkey: 'answer_text',
    ykeys: ['answer_occurrence'],
    labels: ['Answer Occurrence'],
    parseTime: false
  }

  drawGraph = function(type, data, $element, options){
    var defaults = {
      element: $element,
      data: data
    }
    var finalOptions = $.extend(defaults, options);
    var graph = new Morris[type](finalOptions);
  }

  this.checkBoxFieldGraph = function(data, $element){
    var outOptions = $.extend(self.checkBoxFieldGraphOptions, barRequired)

    drawGraph("Bar", data, $element, outOptions);
  }

  this.selectFieldGraph = function(data, $element){
    var outOptions = $.extend(self.selectFieldGraphOptions, barRequired)

    drawGraph("Bar", data, $element, outOptions);
  }
  
  this.rankFieldGraph = function(data, $element){
    var outOptions = $.extend(self.rankFieldGraphOptions, lineRequired)

    drawGraph("Line", data, $element, outOptions);
  }
  
  this.radioButtonFieldGraph = function(data, $element){
    var outData = $.map(data, function(answer, index){
      return { value: answer.answer_occurrence, label: answer.answer_text };
    });
    
    drawGraph("Donut", outData, $element, self.radioButtonFieldGraphOptions);
  }

  return self;
}

var Surveyable = Surveyable();

$(document).ready(function(){
  var $reportableQuestion = $(".reportable_question");
  
  if ($reportableQuestion.length > 0){
    $reportableQuestion.each(function( index ){
      var $element = $(this).closest('.question').find('.graph');
      
      $.ajax({
        url: "/surveyable/questions/"+$(this).val()+"/reports",
        dataType: "json",
        success: function(results){
          if (results.field_type == "check_box_field") {
            Surveyable.checkBoxFieldGraph(results.answers, $element);

          } else if (results.field_type == "rank_field") {
            Surveyable.rankFieldGraph(results.answers, $element);
          
          } else if (results.field_type == "radio_button_field") {
            Surveyable.radioButtonFieldGraph(results.answers, $element);
          
          } else if (results.field_type == "select_field") {
            Surveyable.selectFieldGraph(results.answers, $element);
          
          }
        }
      });
    });
  }
});


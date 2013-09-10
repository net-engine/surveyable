var Surveyable = function(){

  var self = this, drawGraph, type, data;

  var barRequired = {
    xkey: 'answer_text',
    ykeys: ['answer_occurrence'],
    labels: ['Answer Occurrence'],
    xLabelAngle: 35
  }

  var lineRequired = {
    xkey: 'answer_text',
    ykeys: ['answer_occurrence'],
    labels: ['Answer Occurrence'],
    parseTime: false
  }

  var drawGraph = function(type, data, $element, options){
    var defaults = {
      element: $element,
      data: data
    }
    var finalOptions = $.extend(defaults, options);
    var graph = new Morris[type](finalOptions);
  }

  this.checkBoxFieldGraph = function(data, $element){
    type = "Bar";
    var inOptions = self.checkBoxFieldGraphOptions;
    var outOptions = $.extend(inOptions, barRequired)

    drawGraph(type, data, $element, outOptions);
  }
  
  this.rankFieldGraph = function(data, $element){
    type = "Line";
    var inOptions = self.rankFieldGraphOptions;
    var outOptions = $.extend(inOptions, lineRequired)

    drawGraph(type, data, $element, outOptions);
  }
  
  this.radioButtonFieldGraph = function(data, $element){
    type = "Donut";
    var outOptions = self.radioButtonFieldGraphOptions;
    var outData = $.map(data, function(answer, index){
      return { value: answer.answer_occurrence, label: answer.answer_text };
    });
    
    drawGraph(type, outData, $element, outOptions);
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
          
          }
        }
      });
    });
  }
});


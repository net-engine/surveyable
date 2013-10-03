var Surveyable;

Surveyable = (function(){

  function Surveyable() {}

  var drawGraph, barRequired, lineRequired;

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

  Surveyable.checkBoxFieldGraph = function(in_data, element){
    var answer_values   = $.map(in_data.answers, function(answer, index){
      return { label: answer.answer_text, value: answer.answer_occurrence }
    });

    var data = [{ values: answer_values }]

    nv.addGraph(function() {
      var chart = nv.models.discreteBarChart()
          .x(function(d) { return d.label })
          .y(function(d) { return d.value })
          .staggerLabels(false)
          .tooltips(false)
          .showValues(true)

      chart.xAxis.rotateLabels(-45);

      d3.select("#" +  element + " svg")
          .datum(data)
        .transition().duration(500)
          .call(chart);

      nv.utils.windowResize(chart.update);

      return chart;
    });
  }

  Surveyable.selectFieldGraph = function(in_data, element){
    var answer_values   = $.map(in_data.answers, function(answer, index){
      return { label: answer.answer_text, value: answer.answer_occurrence }
    });

    var data = [{ values: answer_values }]

    nv.addGraph(function() {
      var chart = nv.models.discreteBarChart()
          .x(function(d) { return d.label })
          .y(function(d) { return d.value })
          .staggerLabels(false)
          .tooltips(false)
          .showValues(true)

      chart.xAxis.rotateLabels(-45);

      d3.select("#" +  element + " svg")
          .datum(data)
        .transition().duration(500)
          .call(chart);

      nv.utils.windowResize(chart.update);

      return chart;
    });
  }
  
  Surveyable.rankFieldGraph = function(in_data, element){
    var answer_values   = $.map(in_data.answers, function(answer, index){
      return { x: index, y: answer.answer_occurrence }
    });

    var data = [{ values: answer_values, key: "Foo" }]

    nv.addGraph(function() {  
      var chart = nv.models.lineChart()
        .showLegend(false)
        .tooltips(false);

      chart.xAxis
         .axisLabel('Range')
         .tickFormat(d3.format(',r'));

      chart.yAxis
         .axisLabel('Responses')
         .tickFormat(d3.format('.02f'));

      d3.select("#" +  element + " svg")
         .datum(data)
       .transition().duration(500)
         .call(chart);

      nv.utils.windowResize(function() { d3.select("#" +  element + " svg").call(chart) });

      return chart;
    });
  }
  
  Surveyable.radioButtonFieldGraph = function(in_data, element){
    var data   = $.map(in_data.answers, function(answer, index){
      return { label: answer.answer_text, value: answer.answer_occurrence }
    });

    nv.addGraph(function() {
      var chart = nv.models.pieChart()
          .x(function(d) { return d.label })
          .y(function(d) { return d.value })
          .showLabels(false)
          .donut(true);

        d3.select("#" +  element + " svg")
            .datum(data)
          .transition().duration(1200)
            .call(chart);

      return chart;
    });
  }

  Surveyable.report = function(data, element) {
    if (data.field_type == "check_box_field") {
      Surveyable.checkBoxFieldGraph(data, element);

    } else if (data.field_type == "rank_field") {
      Surveyable.rankFieldGraph(data, element);
    
    } else if (data.field_type == "radio_button_field") {
      Surveyable.radioButtonFieldGraph(data, element);
    
    } else if (data.field_type == "select_field") {
      Surveyable.selectFieldGraph(data, element);
    
    }
  }

  return Surveyable;

})();

$(document).ready(function(){
  var $reportableQuestion = $(".reportable_question");
  
  if ($reportableQuestion.length > 0){
    $reportableQuestion.each(function( index ){
      var element = $(this).closest('.question').find('.graph').attr('id');
      
      $.ajax({
        url: "/surveyable/questions/"+$(this).val()+"/reports",
        dataType: "json",
        success: function(results){
          Surveyable.report(results, element);
        }
      });
    });
  }
});


var Surveyable;

Surveyable = (function(){

  function Surveyable() {}

  Surveyable.graphColors = d3.scale.category20c().range();
  Surveyable.charts = [];

  Surveyable.checkBoxFieldGraph = function(in_data, element){
    var answer_values   = $.map(in_data.answers, function(answer, index){
      return { label: answer.answer_text, value: answer.answer_occurrence }
    });

    var data = [{ values: answer_values }];

    nv.addGraph(function() {
      var chart = nv.models.discreteBarChart()
          .x(function(d) { return d.label })
          .y(function(d) { return d.value })
          .staggerLabels(false)
          .tooltips(false)
          .showValues(true)
          .color(Surveyable.graphColors);

      chart.yAxis
        .tickFormat(d3.format('d'));

      chart.valueFormat(d3.format('d'));

      if (data.length > 8) {
        chart.xAxis.rotateLabels(-30);
      } else {
        chart.staggerLabels(true)
      }

      d3.select("#" +  element + " svg")
          .datum(data)
        .transition().duration(500)
          .call(chart);

      nv.utils.windowResize(chart.update);

      Surveyable.charts.push(chart);

      return chart;
    });
  };

  Surveyable.selectFieldGraph = function(in_data, element){
    var answer_values   = $.map(in_data.answers, function(answer, index){
      return { label: answer.answer_text, value: answer.answer_occurrence }
    });

    var data = [{ values: answer_values }];

    nv.addGraph(function() {
      var chart = nv.models.discreteBarChart()
          .x(function(d) { return d.label })
          .y(function(d) { return d.value })
          .staggerLabels(false)
          .tooltips(false)
          .showValues(true)
          .color(Surveyable.graphColors);

      chart.yAxis
        .tickFormat(d3.format('d'));

      chart.valueFormat(d3.format('d'));

      if (data.length > 8) {
        chart.xAxis.rotateLabels(-30);
      } else {
        chart.staggerLabels(true)
      }

      d3.select("#" +  element + " svg")
          .datum(data)
        .transition().duration(500)
          .call(chart);

      nv.utils.windowResize(chart.update);

      Surveyable.charts.push(chart);

      return chart;
    });
  };

  Surveyable.rankFieldGraph = function(in_data, element){
    var answer_values   = $.map(in_data.answers, function(answer, index){
      return { x: index, y: answer.answer_occurrence }
    });

    var data = [{ values: answer_values }]

    nv.addGraph(function() {
      var chart = nv.models.lineChart()
        .showLegend(false)
        .tooltips(false)
        .color(Surveyable.graphColors);

      chart.xAxis
         .tickFormat(d3.format('d'));

      chart.yAxis
         .tickFormat(d3.format('d'));

      d3.select("#" + element + " svg")
         .datum(data)
       .transition().duration(500)
         .call(chart);

      nv.utils.windowResize(chart.update);

      Surveyable.charts.push(chart);

      return chart;
    });
  };

  Surveyable.radioButtonFieldGraph = function(in_data, element){
    var data = $.map(in_data.answers, function(answer, index){
      return { label: answer.answer_text, value: answer.answer_occurrence }
    });

    nv.addGraph(function() {
      var chart = nv.models.pieChart()
          .x(function(d) { return d.label })
          .y(function(d) { return d.value })
          .showLabels(false)
          .showLegend(false)
          .tooltips(false)
          .donut(true)
          .margin({ top: 0, bottom: 0 })
          .color(Surveyable.graphColors);

        d3.select("#" + element + " svg")
            .datum(data)
          .transition().duration(1200)
            .call(chart);

      nv.utils.windowResize(chart.update);

      Surveyable.charts.push(chart);

      return chart;
    });

    $("#" +  element + " .legend").html('');

    $(data).each(function(index){
      $("#" +  element + " .legend").append($("<li style='color: " + Surveyable.graphColors[index] + "' class='series_" + index + "'>" + this.label + "<span class=\"value\">" + this.value + "</span></li>"));
    });
  };

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
  };

  Surveyable.build = function(){
    var $graphQuestions = $(".graph_report");
    var $textQuestions = $(".text_report");

    if ($graphQuestions.length > 0){
      $graphQuestions.each(function(index){
        var element = $(this).closest('.question').find('.graph').attr('id');

        $.ajax({
          url: "/surveyable/questions/" + $(this).val() + "/reports",
          dataType: "json",
          data: $("#entityFilter").serialize(),
          success: function(results){
            Surveyable.report(results, element);
          }
        });
      });
    }

    if ($textQuestions.length > 0){
      $textQuestions.each(function(index){
        $(this).closest(".question").find(".response_answers").empty();
        $.ajax({
          url: "/surveyable/questions/" + $(this).val() + "/response_answers",
          data: $("#entityFilter").serialize()
        });
      });
    }
  }

  Surveyable.bindCsvLink = function(){
    $(document).off('click', '#surveyReportCsvLink');
    $(document).on('click', '#surveyReportCsvLink', function(e){
      e.preventDefault();
      var url = window.location + ".csv?" + $("#entityFilter").serialize();
      window.location = url;
      return false;
    });
  }

  return Surveyable;

})();

$(document).ready(function(){
  Surveyable.build();
  Surveyable.bindCsvLink();
});


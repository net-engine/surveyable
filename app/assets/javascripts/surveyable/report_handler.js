(function(w){

  var draw = function($pieChart, results){
    var width = 960,
      height = 500,
      radius = Math.min(width, height) / 2;
    var color = d3.scale.ordinal()
      .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);
    var arc = d3.svg.arc()
      .outerRadius(radius - 10)
      .innerRadius(0);
    var svg = d3.select($pieChart.toArray()[0]).append("svg")
      .attr("width", width)
      .attr("height", height)
      .append("g")
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

    var pie = d3.layout.pie()
      .value(function(d) { return d.percentage; });

    var g = svg.selectAll(".arc")
      .data(pie(results))
      .enter().append("g")
      .attr("class", "arc");

    g.append("path")
      .attr("d", arc)
      .style("fill", function(d) { return color(d.data.percentage); });

    g.append("text")
      .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
      .attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text(function(d) { return d.data.text + " (" + d.data.occurrence + ") " + d.data.percentage + "%" ; });
  };


  $(document).ready(function(){
    var $reportableQuestion = $(".reportable_question");
    if ($reportableQuestion.length > 0){
      $reportableQuestion.each(function( index ){
        var $pieChart = $(this).siblings(".pie-chart");
        $.ajax({
          url: "/surveyable/questions/"+$(this).val()+"/reports",
          dataType: "json",
          success: function(results){
            draw($pieChart, results);
          }
        });
      });
    }
  });

})(window);
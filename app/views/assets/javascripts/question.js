$(document).ready(function(){
  getQuestion()

  function getQuestion(){
    $.ajax({
      url: $('.graphic').data('url') + "/dashboards/data_question",
      success: function(array){
        keys = Object.keys(array)
        value = Object.keys(array).map(function (key) { return array[key]; });
        chartQuestion(keys, value)
      }
    })
  }

  function chartQuestion(category, data){
    Highcharts.chart('chartQuestion', {
      chart: {
        type: 'area'
      },
      title: {
        text: null
      },
      xAxis: {
        categories: category,
        lineColor: '#111111',
        lineWidth: 1,
        labels: {
          style: {
            fontSize: 16
          }
        },
      },
      yAxis: {
        max: 200,
        tickInterval: 50,
        title: {
          text: null
        },
        labels: {
          style: {
            fontSize: 16
          }
        },
      },
      tooltip: {
        pointFormat: '<b>{point.y:,.0f}</b>% Post Pertanyaan'
      },
      plotOptions: {
        area: {
          fillColor: {
            linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
            stops: [
              [0, '#F76B1C'],
              [1, '#FAD961']
            ]
          },
          marker: {
            enabled: false,
            states: {
              hover: {
                enabled: true
              }
            }
          }
        }
      },
      legend: {
        enabled: false,
      },
      series: [{
        name: 'Question',
        data: data,
        lineWidth: 3,
        lineColor: '#F76B1C'
      }],
      credits: {
        enabled: false
      }
    });
  }

})
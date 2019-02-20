$(document).ready(function(){
  getQuestion()

  $('button#question').on('click', function(){
    getQuestion()
  })

  function getQuestion(){
    mf = $("select#mf").val()
    yf = $("select#yf").val()
    mt = $("select#mt").val()
    yt = $("select#yt").val()
    $.ajax({
      url: $('.graphic').data('url') + "/dashboards/data_question?month_from="+mf+"&year_from="+yf+"&month_to="+mt+"&year_to="+yt,
      success: function(array){
        keys = Object.keys(array)
        value = Object.values(array)
        chartQuestion(keys, value)
      }
    })
  }

  function chartQuestion(category, data){
    var chart_length = Math.max.apply(null, data)

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
        max: chart_length,
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
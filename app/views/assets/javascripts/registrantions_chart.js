$(function(){
    chartRegistration()

    function getData() {
        $.ajax({
            url: $('.graphic').data('url') + "/dashboards/data_question",
            success: function(data){

            }
        })
    }

    function chartRegistration(params) {
        // Registration
        Highcharts.chart('chartRegistration', {
          chart: {
            type: 'area'
          },
          title: {
            text: null
          },
          xAxis: {
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun'],
            lineColor: '#111111',
            lineWidth: 1,
            labels: {
              style: {
                fontSize: 16
              }
            },
          },
          yAxis: {
            max: 100,
            tickInterval: 50,
            title: {
              text: null
            },
            labels: {
              style: {
                fontSize: 16
              }
            }
          },
          tooltip: {
            pointFormat: '<b>{point.y:,.0f}</b> Registration'
          },
          plotOptions: {
            area: {
              fillColor: {
                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
                stops: [
                  [0, '#08bda8'],
                  [1, '#ddf4f1']
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
            name: 'Registration',
            data: [20, 50, 82, 65, 56, 100],
            lineWidth: 3,
            lineColor: '#08bda8'
          }],
          credits: {
            enabled: false
          }
        });
    }
})
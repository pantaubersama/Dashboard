$(function () {
  getData()

  $('#chart_registrantion_form').on('submit', function (event) {
    event.preventDefault()
    month_from = $(this).find('select[name="month_from_registration"]').val()
    year_from = $(this).find('select[name="year_from_registration"]').val()
    month_to = $(this).find('select[name="month_to_registration"]').val()
    year_to = $(this).find('select[name="year_to_registration"]').val()

    getData(month_from, year_from, month_to, year_to)
    // set label html
    $('#rangeRegistration').html(
      $(this).find('select[name="month_from_registration"] option:selected').text()+' '+year_from+ ' - ' +
      $(this).find('select[name="month_to_registration"] option:selected').text()+' '+ year_to
    )
  })

  function getData (month_from, year_from, month_to, year_to) {
    $.ajax({
      url: $('.graphic').data('url') + '/dashboards/data_registration',
      data: {
        month_from_registration: month_from,
        year_from_registration: year_from,
        month_to_registration: month_to,
        year_to_registration: year_to
      },
      success: function (data) {
        // call chart registrations
        chartRegistration(Object.keys(data), Object.values(data))
      }
    })
  }

  function chartRegistration (labels, values) {
    var currentMaxValue = Math.max.apply(null, values)

    Highcharts.chart('chartRegistration', {
      chart: {
        type: 'area'
      },
      title: {
        text: null
      },
      xAxis: {
        categories: labels,
        lineColor: '#111111',
        lineWidth: 1,
        labels: {
          style: {
            fontSize: 16
          }
        }
      },
      yAxis: {
        max: currentMaxValue,
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
            linearGradient: {
              x1: 0,
              y1: 0,
              x2: 0,
              y2: 1
            },
            stops: [[0, '#08bda8'], [1, '#ddf4f1']]
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
        enabled: false
      },
      series: [
        {
          name: 'Registration',
          data: values,
          lineWidth: 3,
          lineColor: '#08bda8'
        }
      ],
      credits: {
        enabled: false
      }
    })
  }
})

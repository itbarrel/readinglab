document.addEventListener("DOMContentLoaded", () => {
  $('#reports_student').change(function() {
    student_id = $(this).val()
    $.ajax({
      url: "/trajectory_details",
      dataType: 'script',
      data: { student_id },
      success: ((response) => {
        let {seasons, grades} = $.parseJSON(response)
        seasons = Object.keys(seasons)
        grades = Object.keys(grades)
        const headings = []
        const student_grades = {}
        const student_data = []
        $.parseJSON(response).trajectory_details.map((td)=>{
          student_grades[`${td.season}-${td.grade}`] = td.wpm - td.error_count
        })
        seasons.map((season)=>{
          grades.map((grade)=>{
            student_data.push((student_grades[`${season}-${grade}`])? student_grades[`${season}-${grade}`] : undefined)
            headings.push(`${season}-${grade}`)
          })
        })
        const series = [{
          name: 'Average Reader',
          data: [10, 20, 30, 25, 30, 45, 40, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100],
          class: 'warning'
        },{
          name: 'Student',
          data: student_data,
          class: 'primary'
        },{
          name: 'Successful Reader',
          data: [20, 40, 60, 55, 80, 85, 90, 100, 120, 125, 130, 140, 145, 150, 160, 165, 170, 180],
          class: 'success'
        }]
        window.graphInit("echart-line-marker-chart", {
          days: headings,
          data: [18,28],
          series: series.map((item)=>{
            return {
              name: item.name,
              type: 'line',
              data: item.data,
              symbolSize: 10,
              itemStyle: {
                color: getGrays().white,
                borderColor: getColor(item.class),
                borderWidth: 2
              },
              lineStyle: {
                color: getColor(item.class)
              },
              symbol: 'circle',
              markPoint: {
                itemStyle: {
                  color: getColor(item.class)
                },
                label: {
                  color: '#fff'
                },
                data: [{
                  name: 'Weekly lowest',
                  value: -2,
                  xAxis: 1,
                  yAxis: -1.5
                }]
              },
              markLine: {
                lineStyle: {
                  color: getColor(item.class)
                },
                label: {
                  color: getGrays()['600']
                },
                data: [{
                  type: 'average',
                  name: 'average'
                },[{
                  symbol: 'none',
                  x: '90%',
                  yAxis: 'max'
                }, {
                  symbol: 'circle',
                  label: {
                    position: 'start',
                    formatter: 'Max'
                  },
                  type: 'max',
                  name: 'Highest point'
                }]]
              }
            }
          })
        })
      })
    });
  });
})

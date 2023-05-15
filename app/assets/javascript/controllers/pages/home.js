$("document").ready(function () {
  window.graphInit("echart-bar-weekly-sales", {
    data: [120, 200, 150, 80, 70, 110, 120],
    xAxisData: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
  })

  // window.graphInit("echart-default-total-order", {
  //   data: [20,40,100,120],
  //   xAxisData: ["Week 4","Week 5","week 6","week 7"]
  // })
});

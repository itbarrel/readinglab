$("document").ready(function () {
  computeWeeklyAttendanceReport()
  computeWeeklyReceiptReport()
  computeStudentsReport()
  computeWeather()
});

const computeWeeklyAttendanceReport = () => {
  $.ajax({
    url: "/reports/weekly_attendance",
    dataType: 'script',
    data: {},
    success: ((response) => {
      response = JSON.parse(response)
      $('#weeking_attendance_count').html(response.total)
      $('#weeking_attendance_precentage').html(`${response.percentage_sign}${response.percentage}%`)
      window.graphInit("echart-bar-weekly-sales", {
        data: Object.values(response.data),
        xAxisData: Object.keys(response.data)
      })
    })
  })
}

const computeWeeklyReceiptReport = () => {
  $.ajax({
    url: "/reports/weekly_receipts",
    dataType: 'script',
    data: {},
    success: ((response) => {
      response = JSON.parse(response)
      $('#weekly_receipts_count').html(response.total)
      $('#weekly_receipts_precentage').html(`${response.percentage_sign}${response.percentage}%`)
      window.graphInit("echart-default-total-order", {
        data: Object.values(response.data).reverse(),
        xAxisData: Object.keys(response.data).reverse()
      })
    })
  })
}

const computeStudentsReport = () => {
  $.ajax({
    url: "/reports/students",
    dataType: 'script',
    data: {},
    success: ((response) => {
      response = JSON.parse(response)
      let html = ''
      console.log(response.data)
      let index = 0
      const graphData = []
      const colors = []
      for (let status in response.data) {
        let count = response.data[status]; index += 1;
        html += '<div class="d-flex flex-between-center mb-1">'
        html += `<div class="d-flex align-items-center"><span class="dot bg-${8 - index}00"></span>`
        html += `<span class="fw-semi-bold">${status}</span></div>`
        html += `<div class="d-xxl-none">${(count/response.total)}%</div></div>`
        graphData.push({
          value: response.data[status],
          name: status,
        })
        colors.push(parseInt(`${8 - index}00`))
      }
      
      $('#students_report').html(html)
      $('#students_report_total').html(response.total)
      window.graphInit("echart-market-share", {
        data: graphData,
        colors
      })
    })
  })
}

const computeWeather = () => {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    console.log("Geolocation is not supported by this browser.");
  }
}

const showPosition = (position) => {
  const latitude = position.coords.latitude;
  const longitude = position.coords.longitude;

  const url = `https://geocode.maps.co/reverse?lat=${latitude}&lon=${longitude}`;

  fetch(url)
  .then(response => response.json())
  .then(data => {
    const city = data.address.city; // Extract the city name from the response
    const weatherUrl = "https://api.weatherapi.com/v1/current.json?key=1234f7328aee47159f793247231206&q=" + encodeURIComponent(city) + "&aqi=yes";

    fetch(weatherUrl)
    .then(response => response.json())
    .then(weatherData => {
      // Use the weather data from the JSON response
      const temperature = weatherData.current.temp_c;
      const condition = weatherData.current.condition.text;
      const humidity = weatherData.current.humidity;
      let image = weatherData.current.condition.icon;
      image = image.replace(/^\/\//, "https://");
      $("#weather-image").attr('src',image);
      $("#weather-humidity").html('<div class="text-warning">' + condition + '</div> Humidity: ' + humidity);
      $("#weather-city").html(city)
      $("#weather-temp").html(temperature + "°")
    })
    .catch(error => {
      console.log("Error fetching weather data:", error);
    });
  })
  .catch(error => {
    console.log("Error fetching city data:", error);
  });
}
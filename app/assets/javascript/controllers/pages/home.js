$("document").ready(function () {
  // window.graphInit("echart-default-total-order", {
  //   data: [20,40,100,120],
  //   xAxisData: ["Week 4","Week 5","week 6","week 7"]
  // })
  computeWeeklyAttendanceReport()
  computeWeather()
});

const computeWeeklyAttendanceReport = () => {
  $.ajax({
    url: "/reports/weekly_attendance",
    dataType: 'script',
    data: {},
    success: ((response) => {
      response = JSON.parse(response)
      console.log('>>>>', response)
      $('#weeking_attendance_count').html(response.total)
      $('#weeking_attendance_precentage').html(`${response.percentage_sign}${response.percentage}`)
      window.graphInit("echart-bar-weekly-sales", {
        data: Object.values(response.data),
        xAxisData: Object.keys(response.data)
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
    const weatherUrl = "http://api.weatherapi.com/v1/current.json?key=1234f7328aee47159f793247231206&q=" + encodeURIComponent(city) + "&aqi=yes";

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
$("document").ready(function () {
  window.graphInit("echart-bar-weekly-sales", {
    data: [120, 200, 150, 80, 70, 110, 120],
    xAxisData: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
  })

  // window.graphInit("echart-default-total-order", {
  //   data: [20,40,100,120],
  //   xAxisData: ["Week 4","Week 5","week 6","week 7"]
  // })

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    console.log("Geolocation is not supported by this browser.");
  }
  
  function showPosition(position) {
    var latitude = position.coords.latitude;
    var longitude = position.coords.longitude;
  
    var url = "https://geocode.maps.co/reverse?lat=" + latitude + "&lon=" + longitude;
  
    fetch(url)
    .then(response => response.json())
    .then(data => {
      var city = data.address.city; // Extract the city name from the response
      var weatherUrl = "http://api.weatherapi.com/v1/current.json?key=1234f7328aee47159f793247231206&q=" + encodeURIComponent(city) + "&aqi=yes";
  
      fetch(weatherUrl)
      .then(response => response.json())
      .then(weatherData => {
        // Use the weather data from the JSON response
        var temperature = weatherData.current.temp_c;
        var condition = weatherData.current.condition.text;
        var humidity = weatherData.current.humidity;
        var image = weatherData.current.condition.icon;
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
});

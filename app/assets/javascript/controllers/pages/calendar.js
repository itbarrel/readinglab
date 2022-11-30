document.addEventListener("DOMContentLoaded", () => {
  var _window3 = window,
    dayjs = _window3.dayjs;
  var currentDay = dayjs && dayjs().format("DD");
  var currentMonth = dayjs && dayjs().format("MM");
  var prevMonth = dayjs && dayjs().subtract(1, "month").format("MM");
  var nextMonth = dayjs && dayjs().add(1, "month").format("MM");
  var currentYear = dayjs && dayjs().format("YYYY");

  const events = [
    {
      url: "/interviews.json",
      method: "GET",
      extraParams: {
        custom_param1: "something",
        custom_param2: "somethingelse",
      },
      failure: function () {
        alert("there was an error while fetching events!");
      },
      color: "yellow", // a non-ajax option
      textColor: "black", // a non-ajax option
    },
  ];
  calendarInit(undefined, events, true);
});

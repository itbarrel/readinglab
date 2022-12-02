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
        cachebuster: new Date().valueOf(),
        pagination: false
      }
    },
    {
      url: "/meetings.json",
      method: "GET",
      extraParams: {
        cachebuster: new Date().valueOf(),
        pagination: false
      }
    },
  ];
  calendarInit(undefined, events, true);
});

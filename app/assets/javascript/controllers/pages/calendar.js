document.addEventListener("DOMContentLoaded", () => {
  var teacher_id = null
  const events = [
    {
      url: "/interviews.json",
      method: "GET",
      color: 'yellow',
      extraParams: {
        cachebuster: new Date().valueOf(),
        pagination: false
      }
    },
    {
      url: "/meetings.json",
      method: "GET",
      // color: '#fef0e8',
      // textColor: '#f2600e',
      extraParams: {
        cachebuster: new Date().valueOf(),
        pagination: false,
        teacher_id,
      }
    }
  ];
  const domEvents = {
    eventClick: (info) => {
      const { event } = info
      $.ajax({
        url: `/meetings/${event.id}`,
        dataType: 'script'
      });
    },
    eventDrop: (info) => {
      const { event, oldEvent } = info
      const date = event.start
      const prevDate = oldEvent.start

      date.setHours(prevDate.getHours())
      date.setMinutes(prevDate.getMinutes())
      date.getSeconds(prevDate.getSeconds())

      $.ajax({
        url: `/meetings/${event.id}`,
        method: 'PUT',
        dataType: 'script',
        data: { meeting: { starts_at: date.toISOString() }}
      });
    },
    dateClick: (info) => {
      $.ajax({
        url: "/vacations/new",
        dataType: 'script',
        data: { start_date: info.date.toISOString() }
      });
    }
  }
  const calendar = calendarInit(undefined, events, true, domEvents);

  $('#calendar_teacher_id').change(function() {
    teacher_id = $(this).val()
    calendar.refetchEvents();
  });
});

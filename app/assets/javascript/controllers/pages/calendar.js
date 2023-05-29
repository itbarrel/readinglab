document.addEventListener("DOMContentLoaded", () => {
  var teacher_id = null
  const events = [
    {
      url: "/interviews.json",
      method: "GET",
      className: 'bg-soft-primary',
      extraParams: {
        cachebuster: new Date().valueOf(),
        pagination: false,
        calendar: true
      }
    },
    {
      url: "/meetings.json",
      method: "GET",
      className: 'bg-soft-primary',
      // color: '#fef0e8',
      // textColor: '#f2600e',
      extraParams: () => {
        return {
          cachebuster: new Date().valueOf(),
          pagination: false,
          teacher_id
        }
      }
    },
    {
      url: "/vacations.json",
      className: 'bg-soft-info',
      method: "GET",
      extraParams: () => {
        return {
          cachebuster: new Date().valueOf(),
          pagination: false
        }
      }
    }
  ];
  const domEvents = {
    eventClick: (info) => {
      const { event } = info
      $.ajax({
        url: `/events/${event.id}`,
        dataType: 'script'
      });
    },
    eventContent: (info) => {
      const { event } = info
      if (event.extendedProps && !('percentage' in event.extendedProps)) return

      let html = `<div class="fc-event-main-frame calender-tiles calender-tiles-${Math.ceil(event.extendedProps.percentage / 20) * 20}">`
      html += '<div class="fc-event-title-container">'
      html += '<div class="fc-event-title fc-sticky">'
      html += event.title
      html += '</div>'
      html += '</div>'
      html += '</div>'
      return { html };
    },
    eventDrop: (info) => {
      const { event, oldEvent } = info
      const date = event.start
      const prevDate = oldEvent.start

      date.setHours(prevDate.getHours())
      date.setMinutes(prevDate.getMinutes())
      date.getSeconds(prevDate.getSeconds())

      $.ajax({
        url: `/events/${event.id}`,
        method: 'PUT',
        dataType: 'script',
        data: { event: { datetime: date.toISOString() }}
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

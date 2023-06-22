document.addEventListener("DOMContentLoaded", () => {
  var teacher_id = null
  let event_filter = 'all'

  const interviews = {
    url: "/interviews.json",
    method: "GET",
    className: 'bg-soft-primary',
    extraParams: {
      cachebuster: new Date().valueOf(),
      pagination: false,
      calendar: true
    }
  }
  const meetings = {
    url: "/meetings.json",
    method: "GET",
    className: 'bg-soft-primary',
    extraParams: () => {
      return {
        cachebuster: new Date().valueOf(),
        pagination: false,
        teacher_id
      }
    }
  }
  const vacations = {
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

  const event_source_mapping = {
    all: [interviews, meetings, vacations],
    interviews: [interviews],
    meetings: [meetings],
    vacations: [vacations]
  }

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
  const calendar = calendarInit(undefined, event_source_mapping[event_filter], true, domEvents);

  $('#calendar_teacher_id').change(function() {
    teacher_id = $(this).val()
    calendar.refetchEvents();
  });

  $('#event-selector').change(function() {
    event_filter = $(this).val()
    console.log(this.value)
    calendar.removeAllEventSources();
    event_source_mapping[event_filter].forEach(function(eventSource) {
      calendar.addEventSource(eventSource);
    });
  });
  
});
// hussnain mubasit

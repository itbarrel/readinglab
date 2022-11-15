const initializeCalendar = (selectorId) => {
  $(`#${selectorId}`).fullCalendar({
    themeSystem: "bootstrap4",
    // emphasizes business hours
    businessHours: false,
    defaultView: "month",
    // event dragging & resizing
    editable: true,
    // header
    header: {
      left: "title",
      center: "month,agendaWeek,agendaDay",
      right: "today prev,next",
    },
    events: [
      {
        title: 'All Day Event',
        start: '2022-08-01'
      },
      {
        title: 'Long Event',
        start: '2022-08-07',
        end: '2022-08-10'
      },
      {
        groupId: '999',
        title: 'Repeating Event',
        start: '2022-08-09T16:00:00'
      },
      {
        groupId: '999',
        title: 'Repeating Event',
        start: '2022-08-16T16:00:00'
      },
      {
        title: 'Conference',
        start: '2022-08-11',
        end: '2022-08-13'
      },
      {
        title: 'Meeting',
        start: '2022-08-12T10:30:00',
        end: '2022-08-12T12:30:00'
      },
      {
        title: 'Lunch',
        start: '2022-08-12T12:00:00'
      },
      {
        title: 'Meeting',
        start: '2022-08-12T14:30:00'
      },
      {
        title: 'Birthday Party',
        start: '2022-08-13T07:00:00'
      },
      {
        title: 'Click for Google',
        url: 'http://google.com/',
        start: '2022-08-28'
      }
    ]
  })
}

$('document').ready(()=>{
  window.initializeCalendar = initializeCalendar
})

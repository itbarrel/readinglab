document.addEventListener("DOMContentLoaded", () => {
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
        pagination: false
      }
    }
  ];
  const domEvents = {
    eventClick: (info) => {
      const { event } = info
      console.log('>>>>event>>>>>>...', event.id)
      // if (info.event.url) {
      //   window.open(info.event.url, "_blank");
      //   info.jsEvent.preventDefault();
      // } else {
      //   const template = getTemplate(info.event);
      //   document.querySelector(
      //     Selectors.EVENT_DETAILS_MODAL_CONTENT
      //   ).innerHTML = template;
      //   const modal = new window.bootstrap.Modal(eventDetailsModal);
      //   modal.show();
      // }
    },
    dateClick: (info) => {
      console.log('>>>>>date>>>>>...', info)
      $.ajax({
        url: "/klasses/new", 
        data: { start_date: info.date.toISOString() }
      });
  
      
      // const modal = new window.bootstrap.Modal(addEventModal);
      // modal.show();
      // /*eslint-disable-next-line*/

      // const flatpickr = document.querySelector(
      //   Selectors.EVENT_START_DATE
      // )._flatpickr;

      // flatpickr.setDate([info.dateStr]);
    }
  }
  calendarInit(undefined, events, true, domEvents);
});

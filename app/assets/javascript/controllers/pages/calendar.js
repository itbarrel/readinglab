document.addEventListener("DOMContentLoaded", () => {
  const _window3 = window,
    dayjs = _window3.dayjs;
  const currentDay = dayjs && dayjs().format("DD");
  const currentMonth = dayjs && dayjs().format("MM");
  const prevMonth = dayjs && dayjs().subtract(1, "month").format("MM");
  const nextMonth = dayjs && dayjs().add(1, "month").format("MM");
  const currentYear = dayjs && dayjs().format("YYYY");

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
  const domEvents = {
    eventClick: (info) => {
      console.log('>>>>event>>>>>>...', info)
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

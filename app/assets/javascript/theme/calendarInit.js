const camelize = function camelize(str) {
  var text = str.replace(/[-_\s.]+(.)?/g, function (_, c) {
    return c ? c.toUpperCase() : "";
  });
  return "".concat(text.substr(0, 1).toLowerCase()).concat(text.substr(1));
};

const getData = (el, data) => {
  try {
    return JSON.parse(el.dataset[camelize(data)]);
  } catch (e) {
    return el.dataset[camelize(data)];
  }
};

const getStackIcon = function getStackIcon(icon, transform) {
  return '\n  <span class="fa-stack ms-n1 me-3">\n    <i class="fas fa-circle fa-stack-2x text-200"></i>\n    <i class="'
    .concat(icon, ' fa-stack-1x text-primary" data-fa-transform=')
    .concat(transform, "></i>\n  </span>\n");
};

const getTemplate = function getTemplate(event) {
  return '\n<div class="modal-header bg-light ps-card pe-5 border-bottom-0">\n  <div>\n    <h5 class="modal-title mb-0">'
    .concat(event.title, "</h5>\n    ")
    .concat(
      event.extendedProps.organizer
        ? '<p class="mb-0 fs--1 mt-1">\n        by <a href="#!">'.concat(
            event.extendedProps.organizer,
            "</a>\n      </p>"
          )
        : "",
      '\n  </div>\n  <button type="button" class="btn-close position-absolute end-0 top-0 mt-3 me-3" data-bs-dismiss="modal" aria-label="Close"></button>\n</div>\n<div class="modal-body px-card pb-card pt-1 fs--1">\n  '
    )
    .concat(
      event.extendedProps.description
        ? '\n      <div class="d-flex mt-3">\n        '
            .concat(
              getStackIcon("fas fa-align-left"),
              '\n        <div class="flex-1">\n          <h6>Description</h6>\n          <p class="mb-0">\n            \n          '
            )
            .concat(
              event.extendedProps.description.split(" ").slice(0, 30).join(" "),
              "\n          </p>\n        </div>\n      </div>\n    "
            )
        : "",
      ' \n  <div class="d-flex mt-3">\n    '
    )
    .concat(
      getStackIcon("fas fa-calendar-check"),
      '\n    <div class="flex-1">\n        <h6>Date and Time</h6>\n        <p class="mb-1">\n          '
    )
    .concat(
      window.dayjs &&
        window.dayjs(event.start).format("dddd, MMMM D, YYYY, h:mm A"),
      " \n          "
    )
    .concat(
      event.end
        ? "\u2013 <br/>".concat(
            window.dayjs &&
              window
                .dayjs(event.end)
                .subtract(1, "day")
                .format("dddd, MMMM D, YYYY, h:mm A")
          )
        : "",
      "\n        </p>\n    </div>\n  </div>\n  "
    )
    .concat(
      event.extendedProps.location
        ? '\n        <div class="d-flex mt-3">\n          '
            .concat(
              getStackIcon("fas fa-map-marker-alt"),
              '\n          <div class="flex-1">\n              <h6>Location</h6>\n              <p class="mb-0">'
            )
            .concat(
              event.extendedProps.location,
              "</p>\n          </div>\n        </div>\n      "
            )
        : "",
      "\n  "
    )
    .concat(
      event.schedules
        ? '\n        <div class="d-flex mt-3">\n        '
            .concat(
              getStackIcon("fas fa-clock"),
              '\n        <div class="flex-1">\n            <h6>Schedule</h6>\n            \n            <ul class="list-unstyled timeline mb-0">\n              '
            )
            .concat(
              event.schedules
                .map(function (schedule) {
                  return "<li>".concat(schedule.title, "</li>");
                })
                .join(""),
              "\n            </ul>\n        </div>\n      "
            )
        : "",
      '\n  </div>\n</div>\n<div class="modal-footer d-flex justify-content-end bg-light px-card border-top-0">\n  <a href="'
    )
    .concat(
      document.location.href.split("/").slice(0, 5).join("/"),
      '/app/events/create-an-event.html" class="btn btn-falcon-default btn-sm">\n    <span class="fas fa-pencil-alt fs--2 mr-2"></span> Edit\n  </a>\n  <a href=\''
    )
    .concat(
      document.location.href.split("/").slice(0, 5).join("/"),
      '/app/events/event-detail.html\' class="btn btn-falcon-primary btn-sm">\n    See more details\n    <span class="fas fa-angle-right fs--2 ml-1"></span>\n  </a>\n</div>\n'
    );
};

const renderCalendar = (el, option) => {
  let _document$querySelect;

  const options = {
    ...{
      initialView: "dayGridMonth",
      editable: true,
      direction: document.querySelector("html").getAttribute("dir"),
      headerToolbar: {
        left: "prev,next today",
        center: "title",
        right: "dayGridMonth,timeGridWeek,timeGridDay",
      },
      buttonText: {
        month: "Month",
        week: "Week",
        day: "Day",
      },
    },
    ...option,
  };

  const calendar = new window.FullCalendar.Calendar(el, options);
  calendar.render();
  (_document$querySelect = document.querySelector(
    ".navbar-vertical-toggle"
  )) === null || _document$querySelect === void 0
    ? void 0
    : _document$querySelect.addEventListener(
        "navbar.vertical.toggle",
        function () {
          return calendar.updateSize();
        }
      );
  return calendar;
};

window.calendarInit = (selectors = {}, events = [], external = false, domEvents = {}) => {
  const Selectors = {
    ACTIVE: selectors.ACTIVE || ".active",
    ADD_EVENT_FORM: selectors.ADD_EVENT_FORM || "#addEventForm",
    ADD_EVENT_MODAL: selectors.ADD_EVENT_MODAL || "#addEventModal",
    CALENDAR: selectors.CALENDAR || "#appCalendar",
    CALENDAR_TITLE: selectors.CALENDAR_TITLE || ".calendar-title",
    DATA_CALENDAR_VIEW: selectors.DATA_CALENDAR_VIEW || "[data-fc-view]",
    DATA_EVENT: selectors.DATA_EVENT || "[data-event]",
    DATA_VIEW_TITLE: selectors.DATA_VIEW_TITLE || "[data-view-title]",
    EVENT_DETAILS_MODAL: selectors.EVENT_DETAILS_MODAL || "#eventDetailsModal",
    EVENT_DETAILS_MODAL_CONTENT:
      selectors.EVENT_DETAILS_MODAL_CONTENT ||
      "#eventDetailsModal .modal-content",
    EVENT_START_DATE:
      selectors.EVENT_START_DATE || '#addEventModal [name="startDate"]',
    INPUT_TITLE: selectors.INPUT_TITLE || '[name="title"]',
  };

  const Events = {
    CLICK: "click",
    SHOWN_BS_MODAL: "shown.bs.modal",
    SUBMIT: "submit",
  };
  const DataKeys = {
    EVENT: "event",
    FC_VIEW: "fc-view",
  };
  const ClassNames = {
    ACTIVE: "active",
  };
  const eventList = external
    ? events
    : events.reduce(function (acc, val) {
        return val.schedules
          ? acc.concat(val.schedules.concat(val))
          : acc.concat(val);
      }, []);

  const updateTitle = function updateTitle(title) {
    document.querySelector(Selectors.CALENDAR_TITLE).textContent = title;
  };

  const appCalendar = document.querySelector(Selectors.CALENDAR);
  const addEventForm = document.querySelector(Selectors.ADD_EVENT_FORM);
  const addEventModal = document.querySelector(Selectors.ADD_EVENT_MODAL);
  const eventDetailsModal = document.querySelector(
    Selectors.EVENT_DETAILS_MODAL
  );

  if (appCalendar) {
    const eventSourcesKey = external ? "eventSources" : "events";
    const calendar = renderCalendar(appCalendar, {
      headerToolbar: false,
      dayMaxEvents: 6,
      height: 800,
      stickyHeaderDates: false,
      views: {
        week: {
          eventLimit: 3,
        },
      },
      eventTimeFormat: {
        hour: "numeric",
        minute: "2-digit",
        omitZeroMinute: true,
        meridiem: true,
      },
      [eventSourcesKey]: eventList,
      ...domEvents
    });
    updateTitle(calendar.currentData.viewTitle);
    document.querySelectorAll(Selectors.DATA_EVENT).forEach(function (button) {
      button.addEventListener(Events.CLICK, function (e) {
        const el = e.currentTarget;
        const type = getData(el, DataKeys.EVENT);

        switch (type) {
          case "prev":
            calendar.prev();
            updateTitle(calendar.currentData.viewTitle);
            break;

          case "next":
            calendar.next();
            updateTitle(calendar.currentData.viewTitle);
            break;

          case "today":
            calendar.today();
            updateTitle(calendar.currentData.viewTitle);
            break;

          case "reload":
            calendar.refetchEvents();
            break;

          default:
            calendar.today();
            updateTitle(calendar.currentData.viewTitle);
            break;
        }
      });
    });
    document
      .querySelectorAll(Selectors.DATA_CALENDAR_VIEW)
      .forEach(function (link) {
        link.addEventListener(Events.CLICK, function (e) {
          e.preventDefault();
          const el = e.currentTarget;
          const text = el.textContent;
          el.parentElement
            .querySelector(Selectors.ACTIVE)
            .classList.remove(ClassNames.ACTIVE);
          el.classList.add(ClassNames.ACTIVE);
          document.querySelector(Selectors.DATA_VIEW_TITLE).textContent = text;
          calendar.changeView(getData(el, DataKeys.FC_VIEW));
          updateTitle(calendar.currentData.viewTitle);
        });
      });
    
    return calendar;
  }
};

/* -------------------------------------------------------------------------- */
/*                                  Draggable                                 */
/* -------------------------------------------------------------------------- */

import utils from '../utils';

window.draggableInit = (options = {}) => {
  const Selectors = {
    BODY: 'body',
    KANBAN_CONTAINER: '.kanban-container',
    KABNBAN_COLUMN: '.kanban-column',
    KANBAN_ITEMS_CONTAINER: '.kanban-items-container',
    KANBAN_ITEM: '.kanban-item',
    ADD_CARD_FORM: '.add-card-form',
  };

  const Events = {
    DRAG_START: 'drag:start',
    DRAG_STOP: 'drag:stop',
  };

  const ClassNames = {
    FORM_ADDED: 'form-added',
  };

  const columns = document.querySelectorAll(Selectors.KABNBAN_COLUMN);
  const columnContainers = document.querySelectorAll(
    Selectors.KANBAN_ITEMS_CONTAINER
  );
  const container = document.querySelector(Selectors.KANBAN_CONTAINER);

  if (!!columnContainers.length) {
    // Initialize Sortable
    const sortable = new window.Draggable.Sortable(columnContainers, {
      draggable: Selectors.KANBAN_ITEM,
      delay: 200,
      mirror: {
        appendTo: Selectors.BODY,
        constrainDimensions: true,
      },
      scrollable: {
        draggable: Selectors.KANBAN_ITEM,
        scrollableElements: [...columnContainers, container],
      },
    });

    // Hide form when drag start
    sortable.on(Events.DRAG_START, options.drag_start);

    // Place forms and other contents bottom of the sortable container
    sortable.on(Events.DRAG_STOP, options.drag_stop);
  }
};

export default draggableInit;

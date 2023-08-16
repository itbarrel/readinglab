/* -------------------------------------------------------------------------- */
/*                                  Draggable                                 */
/* -------------------------------------------------------------------------- */

import utils from '../utils';

const drag_start = ()=>{}
const drag_stop = ({ data })=>{
  setTimeout(()=>{
    const { source: el } = data
    const klass_id = $('#klass_id').attr('name')
    const student_class_id = data.source.id
    const klass_form_id = data.originalSource.parentNode.id
    const sourceContainerId = data.sourceContainer.id

    if (klass_form_id == sourceContainerId) return

    const student_form = { klass_form_id }
    const student_forms_attributes = []

    if(klass_form_id == 'unassigned'){
      student_forms_attributes.push({
        id: student_class_id,
        _destroy: true
      })
    } else {
      if (sourceContainerId == 'unassigned'){
        student_forms_attributes.push({
          klass_form_id, student_class_id
        })
      } else {
        student_forms_attributes.push({
          id: student_class_id,
          _destroy: true
        })
        student_forms_attributes.push({
          klass_form_id,
          student_class_id: data.originalSource.attributes['data-scid'].nodeValue
        })
      }
    }

    if(klass_id && student_class_id){
      $.ajax({
        url: `/klasses/${klass_id}`,
        method: 'PUT',
        dataType: 'script',
        data: { klass: { student_forms_attributes }}
      });
    }
  }, 0)
}

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
    sortable.on(Events.DRAG_START, (options.drag_start || drag_start));

    // Place forms and other contents bottom of the sortable container
    sortable.on(Events.DRAG_STOP, (options.drag_stop || drag_stop));
  }
};

export default draggableInit;

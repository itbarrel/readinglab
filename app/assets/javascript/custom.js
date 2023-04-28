window.assignBulkActions = (resourceId) => {
  $(`#table-${resourceId}-actions button`).click((event)=>{
    const value = $(`#table-${resourceId}-actions select`).val()
    switch (value){
      case "Delete":
        const selected_ids = $(`#table-${resourceId}-body input:checkbox.form-check-input:checked`).map((i, elem) => {
          return elem.id;
        }).get();

        $.ajax({
          url: `/${resourceId}/trash`,
          method: 'DELETE',
          dataType: 'script',
          data: { ids: selected_ids }
        });

        break;
      default: 
        alert('Default case');
    }
    
  })
}
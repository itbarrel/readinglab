$("document").ready(function () {
  assignBulkActions('klasses')

  $('.obsolete_switch').on('change',function(e){
    const value = $(e.target).prop("checked")
    const id = e.target.id.replace("switch_", "")

    $.ajax({
      url: `/klasses/${id}/mark_obsolete`,
      method: "PUT",
      dataType: 'script',
      data: { obsolete: value }
    });
  });
})

$("document").ready(function () {
  assignBulkActions('staffs')

  $('.staff_switch').on('change',function(e){
    const value = $(e.target).prop("checked")
    const id = e.target.id.replace("switch_", "")

    $.ajax({
      url: `/staffs/${id}/mark_active`,
      method: "PUT",
      dataType: 'script',
      data: { active: value }
    });
  });
})

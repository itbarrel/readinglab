$("document").ready(function () {
  $('.form-student-cross').click((event)=>{
    $( `.cross_${event.target.id.replace('delete_', '')}`).remove();
  })
  $('.studentFormSave').click((event)=>{
    var formData = {};
    $.each($(`#studentsForm-${event.target.id}`).serializeArray(), function(i, field) {
      formData[field.name] = field.value;
    });

    if (formData.record_id){
      $.ajax({
        url: `/meetings/${formData.record_id}/form`,
        method: "PUT",
        data: formData,
        dataType: 'script'
      });
    }
  })
});

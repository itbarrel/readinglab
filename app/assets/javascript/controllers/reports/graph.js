document.addEventListener("DOMContentLoaded", () => {
  $('#reports_student').change(function() {
    student_id = $(this).val()
    console.log('>>>>>>>.', student_id)
    $.ajax({
      url: "/trajectory_details",
      dataType: 'script',
      data: { student_id }
    });
  });
})
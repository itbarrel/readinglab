document.addEventListener("DOMContentLoaded", () => {
  $('#reports_student').change(function() {
    student_id = $(this).val()
    $.ajax({
      url: "/trajectory_details",
      dataType: 'script',
      data: { student_id },
    });
  });
})

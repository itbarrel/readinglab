document.addEventListener("DOMContentLoaded", () => {
  $.ajax({
    url: "/books",
    dataType: 'script',
  });

  $.ajax({
    url: "/grades",
    dataType: 'script',
  });

  $('#reports_student').change(function() {
    student_id = $(this).val()
    $.ajax({
      url: "/trajectory_details",
      dataType: 'script',
      data: { student_id },
    });
  });
})

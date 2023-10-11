document.addEventListener("DOMContentLoaded", () => {
  const get_details = (student_id) => {
    $.ajax({
      url: "/trajectory_details",
      dataType: 'script',
      data: { student_id },
    });
  }

  get_details($('#reports_student').val())

  $('#reports_student').change(function() {
    get_details($(this).val())
  });
})
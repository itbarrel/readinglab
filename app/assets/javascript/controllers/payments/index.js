document.addEventListener("DOMContentLoaded", () => {
  var student_id = null
  const fetchPayments = () => {
    $.ajax({
      url: `/payments`,
      method: 'GET',
      dataType: 'script',
      data: { student_id }
    });
  }

  $('#payment_student').change(function() {
    student_id = $(this).val()
    fetchPayments()
  });
})

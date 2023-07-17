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

  var student_id = null
  const updatePayment = () => {
    $.ajax({
      url: `/payments`,
      method: 'GET',
      dataType: 'script',
      data: { student_id }
    });
  }

  $('.payment_meeting').change(function() {
    student_id = $(this).val()
    console.log(student_id);
    // updatePayment()
  });
})
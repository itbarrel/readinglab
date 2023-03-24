
// $(document).on('click', 'form .remove_fields', function(event) {
//   $(this).prev('input[type=hidden]').val('1');
//   $(this).closest('fieldset').hide();
//   return event.preventDefault();
// });

// $(document).on('click', 'form .add_fields', function(event) {
//   var regexp, time;
//   time = new Date().getTime();
//   regexp = new RegExp($(this).data('id'), 'g');
//   $(this).before($(this).data('fields').replace(regexp, time));
//   return event.preventDefault();
// });
$(document).ready(() => {
  $('.form-field-type').on('change', function() {
    alert( this.value );
  });
    // $('.add-field-values').hide()
});


$(document).on('click', '.add-field-values', function(event) {
  console.log(event)
  $('.add-field-values').hide()
  // var regexp, time;
  // time = new Date().getTime();
  // regexp = new RegExp($(this).data('id'), 'g');
  // $(this).before($(this).data('fields').replace(regexp, time));
  // return event.preventDefault();
});





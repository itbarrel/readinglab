const initializeDataTable = (selector, checkBoxNeeded = false, buttonsNeeded = false, scrollCollapse = false, searching = false, bPaginate = false) => {
  const columnDefs = (checkBoxNeeded)? [{
    'targets': 0,
    'searchable': false,
    'orderable': false,
    'className': 'dt-body-center',
    'render': function (data, type, full, meta){
      return '<div class="dt-checkbox"><input type="checkbox" name="id[]" value="' + $('<div/>').text(data).html() + '"><span class="dt-checkbox-label"></span></div>';
    }
  }] : [{
    targets: "datatable-nosort",
    orderable: false,
  }]

  const buttons = []
  if (buttonsNeeded){
    buttons.push('csv')
    buttons.push('pdf')
    buttons.push('print')
  }

  const table = $(selector).DataTable({
    scrollCollapse,
    autoWidth: false,
    responsive: true,
    searching,
    bLengthChange: false,
    bPaginate,
    bInfo: false,
    columnDefs,
    lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
    language: {
      "info": "_START_-_END_ of _TOTAL_ entries",
      searchPlaceholder: "Search",
      paginate: {
        next: '<i class="ion-chevron-right"></i>',
        previous: '<i class="ion-chevron-left"></i>'
      }
    },
    dom: 'Bfrtp',
    buttons
  });

  $('#example-select-all').on('click', function(){
    var rows = table.rows({ 'search': 'applied' }).nodes();
    $('input[type="checkbox"]', rows).prop('checked', this.checked);
  });

  $(`${selector} tbody`).on('change', 'input[type="checkbox"]', function(){
		if(!this.checked){
			var el = $('#example-select-all').get(0);
			if(el && el.checked && ('indeterminate' in el)){
				el.indeterminate = true;
			}
		}
	});
}

$('document').ready(()=>{
  window.initializeDataTable = initializeDataTable

  $('.multiple-select-row tbody').on('click', 'tr', function () {
      $(this).toggleClass('selected');
  });
})

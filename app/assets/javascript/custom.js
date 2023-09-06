function downloadFile(fileName, csv) {
  if (navigator.userAgent.indexOf('MSIE') !== -1
      || navigator.appVersion.indexOf('Trident/') > 0) {
      var IEwindow = window.open("", "", "Width=0px; Height=0px");
      IEwindow.document.write('sep=,\r\n' + csv);
      IEwindow.document.close();
      IEwindow.document.execCommand('SaveAs', true, fileName);
      IEwindow.close();
  }
  else {
      var aLink = document.createElement('a');
      var evt = document.createEvent("MouseEvents");
      evt.initMouseEvent("click", true, true, window,
          0, 0, 0, 0, 0, false, false, false, false, 0, null);
      aLink.download = fileName;
      aLink.href = 'data:text/csv;charset=UTF-8,' + encodeURIComponent(csv);
      aLink.dispatchEvent(evt);
  }
}

window.assignBulkActions = (resourceId) => {
  $(`#table-${resourceId}-actions button`).click((event)=>{
    const value = $(`#table-${resourceId}-actions select`).val()
    let selected_ids = []
    console.log(value);
    switch (value){
      case "Delete":
        selected_ids = $(`#table-${resourceId}-body input:checkbox.form-check-input:checked`).map((i, elem) => {
          return elem.id;
        }).get();

        $.ajax({
          url: `/${resourceId}/trash`,
          method: 'DELETE',
          dataType: 'script',
          data: { ids: selected_ids }
        });

        break;
      case "Export":
        selected_ids = $(`#table-${resourceId}-body input:checkbox.form-check-input:checked`).map((i, elem) => {
          return elem.id;
        }).get();

        const params = {
          meetings: { ids: selected_ids, date: $('#classes_at').val() },
          form_details: { ids: selected_ids, student_id: $('#search_student_id').val() }
        }

        $.ajax({
          url: `/${resourceId}/export`,
          method: 'GET',
          // processData: false,
          contentType: "application/json",
          data: params[resourceId],
          success: function (result) {
            // var csv = JSON.parse(result.replace(/"([\w]+)":/g, function ($0, $1) { return ('"' + $1.toLowerCase() + '":'); }));
            downloadFile('download.csv', result);
            // window.open("data:text/csv;charset=UTF-8", result, "_blank");
          }
        });
        break;
      default:
        alert('Default case');
    }

  })
}

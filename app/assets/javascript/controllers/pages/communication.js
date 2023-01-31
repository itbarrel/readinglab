document.addEventListener("DOMContentLoaded", () => {
  $.ajax({
    url: "/students",
    dataType: 'script',
    data: { q: { status_eq: 'active' }}
  });

  $.ajax({
    url: "/staffs",
    dataType: 'script'
  });

  $("#communicationForm").submit(function(e){
    e.preventDefault();
    const form = $(this);

    const ref_this = $("#communication-tabs li a.active");
    const tab_id = ref_this[0].id

    const tabs_mapping = {
      'klasses-tab': 'klasses',
      'students-tab': 'students',
      'staffs-tab': 'staffs'
    }

    const record_ids = []
    $(`.communications-${tabs_mapping[tab_id]}:checkbox:checked`).map((key, record) => record_ids.push(record.id))
    const data = { record_ids, record_type: tabs_mapping[tab_id] }
    $("#communicationForm").serializeArray().map((item)=>{ data[item.name] = item.value })
    console.log(data)

    $.ajax({
      url: '/notify',
      method: 'POST',
      dataType: 'script',
      data
    });
  });
})

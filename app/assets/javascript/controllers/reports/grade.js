document.addEventListener("DOMContentLoaded", () => {
  $.ajax({
    url: "/grades",
    dataType: 'script',
  });
})
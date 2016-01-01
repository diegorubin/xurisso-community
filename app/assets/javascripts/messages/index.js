$(document).ready(function() {
  $('#page-content').on('click', 'a.remove-message', function(event) {
    event.stopPropagation();
    event.preventDefault();

    var link = $(this);

    $.ajax({
      type: "DELETE",
      url: link.attr("href"),
      data: {xhr:true},
      success: function(){
        link.closest("tr").remove();
      }
    });

  });
});


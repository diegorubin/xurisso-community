$(document).ready(function() {
  $("body a.remove-message").on('click', function(event) {
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


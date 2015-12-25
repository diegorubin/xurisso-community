$(document).ready(function() {
  $("a.remove-message").live('click', function(event) {
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


$(document).ready(function() {

  $('#page-content').on("click", 'li.album', function(e) {
    window.location.hash =  $(this).find("a").first().attr("href");
  });

  $('#page-content').on('click', 'a.remove-album', function(event) {
    event.stopPropagation();
    event.preventDefault();

    var link = $(this);
    if(link.attr("a-confirm") && !confirm(link.attr("a-confirm"))) return false;

    $.ajax({
      type: "DELETE",
      url: link.attr("href"),
      data: {xhr:true},
      success: function(){
        link.closest("li").remove();
      }
    });

  });

  $('#page-content').on('click', 'a.edit-album', function(event) {
    event.stopPropagation();
    event.preventDefault();

    form.show_edit_dialog($(this).attr("href"));
  });

  $('#page-content').on('click', '#album-new', function(e) {
    e.preventDefault();
    form.show_dialog($(this).attr("href"));
  });

});

function AlbumIndex() {
  var self = this;

  self.init = function() {

    if(!$("#new-album-dialog").is(':data(dialog)'))
      $("#new-album-dialog").dialog(
        {
          autoOpen: false,
          modal: true,
          buttons:[
            {
              text: "Salvar",
              click: function(){ form.save(); }
            },
            {
              text: "Cancelar",
              click: function(){ $(this).dialog("close")}
            }
          ]
        }
      );

    if(!$("#edit-album-dialog").is(':data(dialog)'))
      $("#edit-album-dialog").dialog(
        {
          autoOpen: false,
          modal: true,
          buttons:[
            {
              text: "Salvar",
              click: function(){ form.update(); }
            },
            {
              text: "Cancelar",
              click: function(){ $(this).dialog("close")}
            }
          ]
        }
      );

  }

  self.show_dialog = function(link) {
    $("#new-album-dialog").html("");
    $.ajax({
      type: "GET",
      url: link,
      data: {xhr:true},
      success: function(data){
        var f = $(data);
        f.attr("class", "");
        self.form = f.find("form").first();

        $("#new-album-dialog").append(f);
        $("#new-album-dialog").dialog("open");
      }
    });
  }

  self.show_edit_dialog = function(link) {
    $("#edit-album-dialog").html("");
    $.ajax({
      type: "GET",
      url: link,
      data: {xhr:true},
      success: function(data){
        var f = $(data);
        f.attr("class", "");
        self.edit_form = f.find("form").first();

        $("#edit-album-dialog").append(f);
        $("#edit-album-dialog").dialog("open");
      }
    });
  }


  self.save = function() {
    var data = {
      'xhr': true,
      'album[title]': self.form.find("#album_title").val(),
      'album[description]': self.form.find("#album_description").val()
    };
    $.ajax({  
      type: "POST",  
      url: self.form.attr("action"),
      data: data,  
      success: function(data) {  
        display_message("Álbum criado com sucesso.", 'success');

        $.ajax({
          type: "GET",
          url: self.form.attr("action") + "/" + data.album.id,
          data: {xhr:true},
          success: function(html){
            $("ul#albums").append(html);
          }
        });

        $("#new-album-dialog").dialog("close");
      },
      error: function() {  
        display_message("Não foi possível criar o álbum.", 'error');
      }
    });  
  }

  self.update = function() {
    var data = {
      'xhr': true,
      'album[title]': self.edit_form.find("#album_title").val(),
      'album[description]': self.edit_form.find("#album_description").val()
    };

    $.ajax({  
      type: "PATCH",
      url: self.edit_form.attr("action"),
      data: data,  
      success: function(data) {  
        var album = $("#album-" + data.album.id);
        album.find("a.album-title").html(data.album.title);
        $("#edit-album-dialog").dialog("close");
      },
      error: function() {  
        display_message("Não foi possível atualizar o álbum.", 'error');
      }
    });  
  }

}


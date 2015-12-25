$(document).ready(function() {

  $("a.remove-photo").live('click', function(event) {
    event.stopPropagation();
    event.preventDefault();

    var link = $(this);
    if(link.attr("a-confirm") && !confirm(link.attr("a-confirm"))) return false;

    $("#notice-msg").slideDown('fast');
    $.ajax({
      type: "DELETE",
      url: link.attr("href"),
      data: {xhr:true},
      success: function(){
        link.closest("li").remove();
        $("#notice-msg").slideUp('fast');
      }
    });

  });

  $("a.edit-photo").live('click', function(event) {
    event.stopPropagation();
    event.preventDefault();

    form.show_edit_dialog($(this).attr("href"));
  });

  $("#photo-new").live('click', function(e) {
    e.preventDefault();
    form.show_dialog($(this).attr("href"));
  });

});

function PhotoIndex() {
  var self = this;

  self.init = function() {
    if(!$("#new-photo-dialog").is(':data(dialog)'))
      $("#new-photo-dialog").dialog(
        {
          autoOpen: false,
          modal: true,
          height: 450, width: 480,
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

    if(!$("#edit-photo-dialog").is(':data(dialog)'))
      $("#edit-photo-dialog").dialog(
        {
          autoOpen: false,
          modal: true,
          height: 450, width: 480,
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
    $("#new-photo-dialog").html("");
    $.ajax({
      type: "GET",
      url: link,
      data: {xhr:true},
      success: function(data){
        var f = $(data);
        f.attr("class", "");
        self.new_form = f.find("form").first();

        $("#new-photo-dialog").append(f);
        $("#new-photo-dialog").dialog("open");
      }
    });
  }

  self.show_edit_dialog = function(link) {
    $("#edit-photo-dialog").html("");
    $.ajax({
      type: "GET",
      url: link,
      data: {xhr:true},
      success: function(data){
        var f = $(data);
        f.attr("class", "");
        self.edit_form = f.find("form").first();

        $("#edit-photo-dialog").append(f);
        $("#edit-photo-dialog").dialog("open");
      }
    });
  }

  self.save = function() {
    var data = new FormData();
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var csrf_token = $('meta[name=csrf-token]').attr('content');

    data.append('xhr', true);
    data.append('photo[title]', self.new_form.find("#photo_title").val());
    data.append('photo[description]', self.new_form.find("#photo_description").val());
    data.append(csrf_param, csrf_token);
    jQuery.each(self.new_form.find('#photo_image')[0].files, function(i, file) {
      data.append('photo[image]', file);
    });

    $("#notice-msg").slideDown('fast');
    $.ajax({  
      type: "POST",
      url: self.new_form.attr("action"),
      data: data,  
      contentType: false,
      processData: false,
      success: function(data) {  

        display_message("Foto adicionada com sucesso.", 'success');
        $.ajax({
          type: "GET",
          url: self.new_form.attr("action") + "/" + data.photo.id,
          data: {xhr:true, partial:true},
          success: function(html){
            $("ul#photos").append(html);
          }
        });

        $("#new-photo-dialog").dialog("close");
        $("#notice-msg").slideUp('fast');
      },
      error: function() {  
        display_message("Não foi possível adicionar a foto.", 'error');
        $("#notice-msg").slideUp('fast');
      }
    });  
  }

  self.update = function() {
    var data = new FormData();
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var csrf_token = $('meta[name=csrf-token]').attr('content');

    data.append('xhr', true);
    data.append('photo[title]', self.edit_form.find("#photo_title").val());
    data.append('photo[description]', self.edit_form.find("#photo_description").val());
    data.append(csrf_param, csrf_token);
    jQuery.each(self.edit_form.find('#photo_image')[0].files, function(i, file) {
      data.append('photo[image]', file);
    });

    $("#notice-msg").slideDown('fast');
    $.ajax({  
      type: "PUT",
      url: self.edit_form.attr("action"),
      data: data,  
      contentType: false,
      processData: false,
      success: function(data) {  
        var photo = $("#photo-" + data.photo.id);
        photo.find("img.photo-thumb").attr("src", data.photo.thumb);
        photo.find("a.photo-title").html(data.photo.title);
        $("#edit-photo-dialog").dialog("close");
        $("#notice-msg").slideUp('fast');
      },
      error: function() {  
        display_message("Não foi possível atualizar a foto.", 'error');
        $("#notice-msg").slideUp('fast');
      }
    });  
  }

}


$(document).ready(function() {

  $('#page-content').on('click', 'a.remove-photo', function(event) {
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

  $('#page-content').on('click', 'a.edit-photo', function(event) {
    event.stopPropagation();
    event.preventDefault();

    form.show_edit_dialog($(this).attr("href"));
  });

  $('#page-content').on('click', "#photo-new", function(e) {
    e.preventDefault();
    form.show_dialog($(this).attr("href"));
  });

});

function PhotoIndex() {
  var _this = this;

  _this.init = function() {
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

  _this.show_dialog = function(link) {
    $("#new-photo-dialog").html("");
    $.ajax({
      type: "GET",
      url: link,
      data: {xhr:true},
      success: function(data){
        var f = $(data);
        f.attr("class", "");
        _this.new_form = f.find("form").first();

        $("#new-photo-dialog").append(f);
        $("#new-photo-dialog").dialog("open");
      }
    });
  }

  _this.show_edit_dialog = function(link) {
    $("#edit-photo-dialog").html("");
    $.ajax({
      type: "GET",
      url: link,
      data: {xhr:true},
      success: function(data){
        var f = $(data);
        f.attr("class", "");
        _this.edit_form = f.find("form").first();

        $("#edit-photo-dialog").append(f);
        $("#edit-photo-dialog").dialog("open");
      }
    });
  }

  _this.save = function() {
    var data = new FormData();
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var csrf_token = $('meta[name=csrf-token]').attr('content');

    data.append('xhr', true);
    data.append('photo[title]', _this.new_form.find("#photo_title").val());
    data.append('photo[description]', _this.new_form.find("#photo_description").val());
    data.append(csrf_param, csrf_token);
    jQuery.each(_this.new_form.find('#photo_image')[0].files, function(i, file) {
      data.append('photo[image]', file);
    });

    $("#notice-msg").slideDown('fast');
    $.ajax({  
      type: "POST",
      url: _this.new_form.attr("action"),
      data: data,  
      contentType: false,
      processData: false,
      success: function(data) {  

        display_message("Foto adicionada com sucesso.", 'success');
        $.ajax({
          type: "GET",
          url: _this.new_form.attr("action") + "/" + data.photo.id,
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

  _this.update = function() {
    var data = new FormData();
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var csrf_token = $('meta[name=csrf-token]').attr('content');

    data.append('xhr', true);
    data.append('photo[title]', _this.edit_form.find("#photo_title").val());
    data.append('photo[description]', _this.edit_form.find("#photo_description").val());
    data.append(csrf_param, csrf_token);
    jQuery.each(_this.edit_form.find('#photo_image')[0].files, function(i, file) {
      data.append('photo[image]', file);
    });

    $("#notice-msg").slideDown('fast');
    $.ajax({  
      type: "PATCH",
      url: _this.edit_form.attr("action"),
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


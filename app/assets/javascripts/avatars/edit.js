var path = "/avatars";

function onload_complete(msg) {
  // fetch the CSRF meta tag data
  var csrf_param = $('meta[name=csrf-param]').attr('content');
  var csrf_token = $('meta[name=csrf-token]').attr('content');

  // reset the api URL appending the auth token parameter
  webcam.set_api_url(path + '?' + csrf_param + "=" + encodeURI(encodeURI(csrf_token)));
}

function upload_complete(msg) {
  if (msg == 'ok') {
    var hash = window.location.hash.slice(1); 
    reload_page(hash, "GET");
  } else {
      alert('An error occured');
      webcam.reset();
  }
}

var AvatarEditForm = function() {
  var _this = this;
};

AvatarEditForm.prototype = new Form();

AvatarEditForm.prototype.constructor = AvatarEditForm;

AvatarEditForm.init = function() {
  var _this = this;
  _this.form = $('.user_edit');

  webcam.set_swf_url('/webcam.swf');
  webcam.set_api_url(path);
  webcam.set_quality(90);
  webcam.set_shutter_sound(true, '/shutter.mp3');
  webcam.set_hook('onLoad', 'onload_complete');
  webcam.set_hook('onComplete', 'upload_complete');
  $('#webcam').html(webcam.get_html(300, 225));

  _this.form.find("input.btn-primary").click(function(event) {
    event.preventDefault();
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var csrf_token = $('meta[name=csrf-token]').attr('content');

    var data = new FormData();
    jQuery.each($('#user_avatar')[0].files, function(i, file) {
        data.append('user[avatar]', file);
    });

    data.append('xhr', true);
    data.append(csrf_param, csrf_token);

    $.ajax({  
      type: "PUT",  
      url: _this.form.attr('action'),
      data: data,  
      contentType: false,
      processData: false,
      error: function(data) {  
        var hash = window.location.hash.slice(1); 
        reload_page(hash, "GET");

        display_message("Informações atualizadas com sucesso.", 'success');
      }
    });  

  });
  
}


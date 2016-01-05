var AvatarEditForm = function() {
  var _this = this;
};

AvatarEditForm.prototype = new Form();

AvatarEditForm.prototype.constructor = AvatarEditForm;

AvatarEditForm.prototype.init = function() {
  var _this = this;
  _this.form = $('.edit_user');

  _this.form.find("input.btn-primary").click(function(event) {
    event.preventDefault();

    var file;
    jQuery.each($('#user_avatar')[0].files, function(i, _file) {
      file = _file;
    });
    _this.sendPicture(file);

  });

  $('#enable-webcam').click(function(event){
    _this.loadCameraInfos();
  });

};

AvatarEditForm.prototype.loadCameraInfos = function() {
  var _this = this;

  Webcam.set({
  	width: 320,
  	height: 240,
  	image_format: 'jpeg',
  	jpeg_quality: 90
  });
  
  Webcam.attach('#webcam');
  
  $('#take-photo').click(function(event){
    event.preventDefault();
  
    Webcam.snap(function(file){
      _this.sendPicture(file);
    });
  });
};

AvatarEditForm.prototype.sendPicture = function(file) {
  var _this = this;

  var csrf_param = $('meta[name=csrf-param]').attr('content');
  var csrf_token = $('meta[name=csrf-token]').attr('content');

  var hash = window.location.hash.slice(1); 
  var data = new FormData();

  data.append('user[avatar]', file);

  data.append('xhr', true);
  data.append(csrf_param, csrf_token);

  var options = {contentType: false, processData: false, dataType: undefined};
  var client = new RestClient(_this.form.attr('action'), options);
  client.success = function(data, textStatus, xhr) {
    reload_page(hash, "GET");

    display_message("Informações atualizadas com sucesso.", 'success');
  };
  client.error = function(data) {
    reload_page(hash, "GET");
  };
  client.call('PATCH', data);
};


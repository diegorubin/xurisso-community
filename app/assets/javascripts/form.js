var Form = function() {};

Form.prototype.loadSubmitButton = function() {
  var _this = this;

  _this.form.submit(function(event){
    event.preventDefault();
    _this.clearErrorsDescription();
    _this.submit();

  });

}

Form.prototype.enableSubmit = function() {
  var _this = this;
  _this.form.find('input[type="submit"]').prop('disabled', false);
}

Form.prototype.clearErrorsDescription = function() {
  $('span.error-description').html('');
}

Form.prototype.showErrors = function(errors) {
  for(var field in errors) {
    var span = $('span[data-field-error="' + field + '"]');
    span.html(errors[field]);
  }
}

Form.prototype.submit = function() {
  var _this = this;

  var action = _this.form.attr('action');
  var method = _this.form.find('input[name="_method"]').val() || 
    _this.form.attr('method') || 'post';

  var data = _this.loadAttributes();
  data['xhr'] = true;

  var client = new RestClient(action);

  client.success = function(data, textStatus, xhr) {
    display_message(data.message, 'success');
    if(_this.success) _this.success(data, textStatus, xhr);
    _this.enableSubmit();
  }

  client.error = function(data) {
    data = data.responseJSON || {message: "Erro desconhecido", errors: {}};
    if(data) {
      display_message(data.message, 'error');
      if(_this.error) _this.error(data);
      _this.showErrors(data.errors);
    }
    setTimeout(function(){ _this.enableSubmit(); }, 500);
    
  }

  client.call(method, data);
  
}

Form.prototype.loadAttributes = function() {
  var _this = this;

  var attrs = {};
  var field_types = ["input", "select", "textarea", "hidden"];
  var i = 0;

  for(var j = 0; j < field_types.length; j++){
    var inputs = _this.form.find(field_types[j]);

    for(i = 0; i < inputs.length; i++) {
      var input = $(inputs[i]);
      attrs[input.attr("name")] = input.val();
    }

  }

  /* get values of radio and checkbox */
  var radios = $("input[type='radio']:checked");
  var name;

  for(i = 0; i < radios.length; i++) {
    name = $(radios[i]).attr('name');
    attrs[name] = $(radios[i]).val();
  }

  var checkboxes = $("input[type='checkbox']");
  for(i = 0; i < checkboxes.length; i++) {
    name = $(checkboxes[i]).attr('name') || '';

    if(name.match(/\[\]$/)) {

      if((typeof attrs[name]) == 'string') {attrs[name] = [];}
      if($(checkboxes[i]).is(":checked"))
        attrs[name].push($(checkboxes[i]).val());

    } else {

      attrs[name] =
        ($(checkboxes[i]).is(":checked") ? $(checkboxes[i]).val() : '');

    }
  }

  return attrs;
};


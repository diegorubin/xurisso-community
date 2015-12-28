function PasswordEditForm() {
  var _this = this;
  _this.form = $('.user_edit');

  _this.init = function() {
  }

  _this.data = function() {

    _this.password = $('#user_password').val();
    _this.password_confirmation = $('#user_password_confirmation').val();

    fields = {'xhr': true,
              'user[password]': _this.password,
              'user[password_confirmation]': _this.password_confirmation};
    return fields;
  }

  _this.form.find("input.btn-primary").click(function(event) {
    event.preventDefault();
    $.ajax({  
      type: "PUT",  
      url: _this.form.attr('action'),
      data: _this.data(),  
      success: function() {  
        display_message("Informações atualizadas com sucesso.", 'success');
        window.location = "/";
      },
      error: function() {  
        display_message("Não foi possível atualizar os dados.", 'error');
      }
    });  

  });
}


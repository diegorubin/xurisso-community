function UserEditForm() {
  var _this = this;
  _this.form = $('.edit_user');

  _this.init = function() {
    $("#user_birthday_str").mask("99/99/9999");
  }

  _this.data = function() {

    _this.name = $('#user_name').val();
    _this.email = $('#user_email').val();
    _this.birthday_str = $('#user_birthday_str').val();
    _this.can_display_birthday = $('#user_can_display_birthday').is(':checked');

    fields = {'xhr': true,
              'user[name]': _this.name,
              'user[birthday_str]': _this.birthday_str,
              'user[can_display_birthday]': _this.can_display_birthday,
              'user[email]': _this.email};
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
      },
      error: function() {  
        display_message("Não foi possível atualizar os dados.", 'error');
      }
    });  

  });
}


function UserEditForm() {
  var self = this;
  self.form = $('.edit_user');

  self.init = function() {
    $("#user_birthday_str").mask("99/99/9999");
  }

  self.data = function() {

    self.name = $('#user_name').val();
    self.email = $('#user_email').val();
    self.birthday_str = $('#user_birthday_str').val();
    self.can_display_birthday = $('#user_can_display_birthday').is(':checked');

    fields = {'xhr': true,
              'user[name]': self.name,
              'user[birthday_str]': self.birthday_str,
              'user[can_display_birthday]': self.can_display_birthday,
              'user[email]': self.email};
    return fields;
  }

  self.form.find("input.btn-primary").click(function(event) {
    event.preventDefault();
    $.ajax({  
      type: "PUT",  
      url: self.form.attr('action'),
      data: self.data(),  
      success: function() {  
        display_message("Informações atualizadas com sucesso.", 'success');
      },
      error: function() {  
        display_message("Não foi possível atualizar os dados.", 'error');
      }
    });  

  });
}


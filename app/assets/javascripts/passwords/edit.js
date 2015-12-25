function PasswordEditForm() {
  var self = this;
  self.form = $('.user_edit');

  self.init = function() {
  }

  self.data = function() {

    self.password = $('#user_password').val();
    self.password_confirmation = $('#user_password_confirmation').val();

    fields = {'xhr': true,
              'user[password]': self.password,
              'user[password_confirmation]': self.password_confirmation};
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
        window.location = "/";
      },
      error: function() {  
        display_message("Não foi possível atualizar os dados.", 'error');
      }
    });  

  });
}


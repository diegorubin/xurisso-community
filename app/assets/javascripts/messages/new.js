function MessageNewForm() {
  var self = this;
  self.form = $('.new_message');

  self.init = function() {
  }

  self.data = function() {

    self.about = $('#message_about').val();
    self.body = $('#message_body').val();

    fields = {'xhr': true,
              'message[about]': self.about,
              'message[body]': self.body};
    return fields;
  }

  self.form.find("input.btn-primary").click(function(event) {
    event.preventDefault();
    $.ajax({  
      type: "POST",  
      url: self.form.attr('action'),
      data: self.data(),  
      success: function() {  
        $('#message_about').val("");
        $('#message_body').val("");
        display_message("Mensagem enviada com sucesso.", 'success');
      },
      error: function() {  
        display_message("Não foi possível enviar a mensagem.", 'error');
      }
    });  

  });
}


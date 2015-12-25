$(document).ready(function() {

  $("#wall_message-new").live('click', function(e) {
    e.preventDefault();
    form.show_dialog($(this).attr("href"));
  });

  $(".survey-button-save").live('click', function(e) {
    e.preventDefault();

    var survey = $(this).closest(".survey");
    var survey_id = survey.find(".survey_id").val();
    var survey_option_id = survey.find("input[type=radio]:checked").val();

    form.save_survey(survey_id, survey_option_id, survey);
  });

});

function DashboardIndex() {
  var self = this;
  self.offset = 0;

  self.init = function() {
    if(!$("#new-wall_message-dialog").is(':data(dialog)'))
      $("#new-wall_message-dialog").dialog(
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

  }

  self.load_wall_messages = function() {
    $.ajax({
      type: "GET",
      url: '/wall_messages',
      data: {xhr:true, offset:self.offset},
      success: function(data){
        $("#mural").append(data);
        self.offset = self.offset + 10;
      }
    });
  }

  self.show_dialog = function(link) {
    $("#new-wall_message-dialog").html("");
    $.ajax({
      type: "GET",
      url: link,
      data: {xhr:true},
      success: function(data){
        var f = $(data);
        f.attr("class", "");
        self.new_form = f.find("form").first();

        $("#new-wall_message-dialog").append(f);
        $("#new-wall_message-dialog").dialog("open");
      }
    });
  }

  self.save_survey = function(survey_id, survey_option_id, surveyobj) {
    var data = {
      xhr: true,
      'survey_answer[survey_id]': survey_id,
      'survey_answer[survey_option_id]': survey_option_id
    };

    $("#notice-msg").slideDown('fast');
    $.ajax({  
      type: "POST",
      url: '/survey_answers',
      data: data,  
      success: function(data) {  

        surveyobj.html(data);

        display_message("Resposta enviada com sucesso.", 'success');
        $("#notice-msg").slideUp('fast');

        self.offset = 0;
        self.load_wall_messages();
      },
      error: function() {  
        display_message("Não foi possível enviar a resposta.", 'error');
        $("#notice-msg").slideUp('fast');
      }
    });
  }

  self.save = function() {
    var data = new FormData();
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var csrf_token = $('meta[name=csrf-token]').attr('content');

    data.append('xhr', true);
    data.append('wall_message[description]', self.new_form.find("#wall_message_description").val());
    data.append(csrf_param, csrf_token);

    $("#notice-msg").slideDown('fast');
    $.ajax({  
      type: "POST",
      url: self.new_form.attr("action"),
      data: data,  
      contentType: false,
      processData: false,
      success: function(data) {  

        display_message("Recado salvo com sucesso.", 'success');

        $("#mural").html("");

        $("#new-wall_message-dialog").dialog("close");
        $("#notice-msg").slideUp('fast');

        self.offset = 0;
        self.load_wall_messages();
      },
      error: function() {  
        display_message("Não foi possível salvar o recado.", 'error');
        $("#notice-msg").slideUp('fast');
      }
    });  
  }

}


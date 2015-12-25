$(function(){

  $("#survey_option-add").click(function(event) {
    event.preventDefault();
    var option = $(newSurveyOption());

    var fields = $('#survey_options');
    fields.append(option);

  });

});


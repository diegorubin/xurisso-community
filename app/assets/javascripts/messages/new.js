var MessageNewForm = function() {
  var _this = this;
}

MessageNewForm.prototype = new Form();
MessageNewForm.prototype.constructor = MessageNewForm;

MessageNewForm.prototype.init = function(form) {
  var _this = this;

  _this.content = {};
  _this.form = $('.new_message');
  _this.loadSubmitButton();

};


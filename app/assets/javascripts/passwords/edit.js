var PasswordEditForm = function() {
  var _this = this;
}

PasswordEditForm.prototype = new Form();
PasswordEditForm.prototype.constructor = PasswordEditForm;

PasswordEditForm.prototype.init = function(form) {
  var _this = this;

  _this.content = {};
  _this.form = $('.edit_user');
  _this.loadSubmitButton();

};

PasswordEditForm.prototype.success = function(data, textStatus, xhr) {
  window.location = '/';
};


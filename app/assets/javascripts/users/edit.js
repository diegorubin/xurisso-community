var UserEditForm = function() {
  var _this = this;
}

UserEditForm.prototype = new Form();

UserEditForm.prototype.constructor = UserEditForm;

UserEditForm.prototype.init = function(form) {
  var _this = this;

  _this.content = {};
  _this.form = $('.edit_user');
  _this.loadSubmitButton();

};


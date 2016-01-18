$(document).ready(function(){
    var notificationHandler = new NotificationList();
    notificationHandler.getNotifications();
    notificationHandler.start();
});

function NotificationList() {
  var _this = this;

  _this.init = function() {
  };

  _this.getNotifications = function() {
    var client = new RestClient('/notifications/list', {dataType: 'html'});
    client.success = function(data, textStatus, xhr) {
      $('#notifications-container').html(data);
    };
    client.call('get', {'xhr': true});
  };

  _this.start = function() {
    setTimeout(function(){
      _this.getNotifications();
    },60000);
  };

}

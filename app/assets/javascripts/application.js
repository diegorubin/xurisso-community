// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-alert
//= require bootstrap-transition
//
//= require dashboard/index
//= require events/index
//

var method = "GET";
$(document).ready(function() {
  $(".alert").alert();

  $("body a").on('click', function(event) {
    var link = $(this);
    if(link.hasClass("normal-link")) return true;

    event.stopPropagation();
    event.preventDefault();
    if(link.attr("a-confirm") && !confirm(link.attr("a-confirm"))) return false;

    if(link.attr("a-method")) method = link.attr("a-method");
    if(link.hasClass("menu-item")) activate_link(link);

    window.location.hash = link.attr("href");

  });

  $(window).bind('hashchange', function () { 
    var hash = window.location.hash.slice(1); 
    if(hash != "localload")
      reload_page(hash);
  });

  var current_location = window.location.hash.slice(1); 
  setTimeout('init_form("' + (current_location || '/') + '")', 100);
});

function reload_page(anchor) {
  $("#notice-msg").slideDown('fast');
  $.ajax({
    type: method,
    url: anchor,
    data: {xhr:true},
    success: function(data){
      $("#page-content").html(data);

      /* execute init routine */
      setTimeout('set_title()', 100);
      setTimeout('init_form("' + anchor + '")', 100);
      $("#notice-msg").slideUp('fast');
    }
  });

  method = "GET";

}

function set_title() {
  var title = $("h1").html() || "";
  top.document.title = title + " - Xurisso Community";
}

function display_message(message, st) {
  $(".app-message").html("");

  var div = $("<div class='alert alert-" + st + " fade in'></div>");
  var a = $("<a href='#' data-dismiss='alert' class='close'>&times;</a>");

  div.append(a);
  div.append(message);

  $(".app-message").append(div);
}

function activate_link(link) {
  link.closest("ul.nav").children().removeClass("active");
  link.parent().addClass("active");
}

function init_form(page) {

  delete this.form;

  if(/\/avatars\/.*?\/edit/.test(page)) {
    this.form = new AvatarEditForm();
    this.form.init();
    return true;
  }

  if(/\/events\/?$/.test(page)) {
    this.form = new EventCalendar();
    this.form.init();
    return true;
  }

  if(/\/passwords\/.*?\/edit/.test(page)) {
    this.form = new PasswordEditForm();
    this.form.init();
    return true;
  }

  if(/\/users\/.*?\/albums\/\d+\/photos/.test(page)) {
    this.form = new PhotoIndex();
    this.form.init();
    return true;
  }

  if(/\/users\/.*?\/albums/.test(page)) {
    this.form = new AlbumIndex();
    this.form.init();
    return true;
  }

  if(/\/users\/.*?\/messages/.test(page)) {
    this.form = new MessageNewForm();
    this.form.init();
    return true;
  }

  if(/\/users\/.*?\/edit/.test(page)) {
    this.form = new UserEditForm();
    this.form.init();
    return true;
  }

  if(/\//.test(page)) {
    this.form = new DashboardIndex();
    this.form.init();
    this.form.load_wall_messages();

    return true;
  }

  return false;
}


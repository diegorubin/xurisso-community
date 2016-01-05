$(document).ready(function() {
  $('#page-content').on('click', ".show-event", function(event) {
    event.preventDefault();
    form.show_event($(this).attr('rel'));
  });
});

function EventCalendar() {
  var self = this;

  self.init = function() {
    current_date = new Date();

    self.day = current_date.getDay();

    self.month = current_date.getMonth() + 1;
    self.current_month = self.month;

    self.year = current_date.getFullYear();
    self.current_year = current_date.getFullYear();

    self.monthname = $("#month-title-calendar");

    $(".arrow-right-calendar").click(function(event) {
      self.nextMonth();
      event.preventDefault();
    });

    $(".arrow-left-calendar").click(function(event) {
      self.prevMonth();
      event.preventDefault();
    });

    $('#page-content').on('click', '.join-event', function(event) {
      event.preventDefault();
      link = $(this);

      var client = new RestClient('/events/' + link.attr('rel') + '.json');
      client.success = function(data, textStatus, xhr) {
        $('li.event-participate').html(self.exit_button(link.attr('rel')));
      };
      client.call('PUT', {join: true});
    });

    $('#page-content').on('click', '.exit-event', function(event) {
      event.preventDefault();
      link = $(this);

      var client = new RestClient('/events/' + link.attr('rel') + '.json');
      client.success = function(data, textStatus, xhr) {
        $('li.event-participate').html(self.join_button(link.attr('rel')));
      };
      client.call('PUT', {exit: true});
    });

    self.loadMonth();
  }

  self.nextMonth = function() {
    self.month++;

    if(self.month > 12) {
      self.month = 1;
      self.year++;
    }

    self.loadMonth();

  };

  self.prevMonth = function() {
    self.month--;

    if(self.month < 1) {
      self.month = 12;
      self.year--;
    }

    self.loadMonth();

  };
  
  self.loadMonth = function() {
    filter = {};

    filter["month"] = self.month > 9 ? self.month : "0" + self.month;
    filter["year"] = self.year;

    $.ajax({
      type: "GET",
      dataType: "json",
      data: filter,
      url: '/events.json',
      success: function(data) {
        self.display(data);
      }
    });

  };

  self.display = function(data) {
    self.monthname.html(data.month_name + " " + self.year);
    self.events = data.events;

    var tds = $("#calendar-table td");
    var days = data.days;

    var outdated = true;
    var month = self.month - 1;

    for(var i = 0; i < days.length; i++) {

      if(days[i-1] && (days[i] < days[i-1])) {
        outdated = !outdated;
        month++;
      }

      var td = $(tds[i]);

      var content = days[i];

      var index = month + "-" + days[i];
      if(data.events[index]) {
        var events = data.events[index];
        
        content = content + "<div class='calendar-event-content'>";
        for(var e in events) {
          content = content + "<div class='calendar-event'>";
          content = content + "<i class='" + events[e].icon_name + "'></i>";
          content = content + "<a class='show-event normal-link' rel='" + index + "#" + e + "' href='#'>" + events[e].title + "</a></div>";
        }
        content = content + "</div>";

      }

      td.html(content);

      td.attr("class", "");


      if(!outdated && (self.day == days[i]) && 
         (self.current_year == self.year) && 
         (self.current_month == self.month))
        td.addClass("current-date");

      if(outdated) td.addClass("outdated");
    }
  };

  self.exit_button = function(id) {
    return "<a class='btn btn-danger exit-event normal-link' rel='" + id + "' href='#'>Não vou mais</a>";
  }

  self.join_button = function(id) {
    return "<a class='btn btn-primary join-event normal-link' rel='"+ id +"' href='#'>Participar</a>";
  }

  self.put_thumb = function(thumb) {
    link = $("<a></a>");
    img = $("<img />");

    img.attr('src', thumb[1]);

    link.attr('class', 'event-member');
    link.attr('href', "/users/" + thumb[0]);

    link.append(img);

    $('li.event-users').append(link);
  }

  self.show_event = function(e) {
    e = e.split('#');
    var title = self.events[e[0]][e[1]].title;
    var description = self.events[e[0]][e[1]].description;
    var event_id = self.events[e[0]][e[1]].id;

    $('li.event-title').html("<strong>Título:</strong> " + title);
    $('li.event-description').html(description);

    $('li.event-participate').html('');
    $('li.event-users').html('');

    $('#link-see-more').attr('href', '');
    $('#see-more').addClass('hide');

    if(event_id) {

      var client = new RestClient('/events/' + event_id + '.json');
      client.success = function(data, textStatus, xhr) {
        var button;
        if(data.current_user_participating)
          button = self.exit_button(data.id);
        else
          button = self.join_button(data.id);
        
        $('li.event-participate').html(button);

        for(var i = 0; i < data.user_thumbs.length; i++) {
          self.put_thumb(data.user_thumbs[i]);
        }

        if(data.body != '') {
          $('#link-see-more').attr('href', '/events/' + data.id);
          $('#see-more').removeClass('hide');
        }
      };
      client.call('GET',{});
    }
  };

}


module ApplicationHelper

  def active(resource)

    if params[:controller] == resource
      "active"
    else
      ""
    end

  end

  def site_active(controller, action)

    if params[:controller] == controller &&
       params[:action] == action
      "active"
    else
      ""
    end

  end

  def wrap_text(text, len)
    text.gsub("\n",'').gsub(/^(.{#{len}}.*?)\ .*$/,'\1...')
  end

  def render_wall_message(message)
    message = h(message)
    message.gsub!(/[^\s><A-Z;]+\.[^\s><A-Z&]+[^\s><\.\&]/) do |link|
      link =~ /(https?:\/\/)/i
      href = $1 ? link : "http://" + link
      link_to link, href, :target => "_blank", 
                          :class => "normal-link"
    end
    raw(message.gsub(/\A/,'<p>').
            gsub(/\n/,'</p><p>').
            gsub(/\z/,'</p>'))
  end

  def show_message_if_error(object, field)
    message = object.errors.messages[field].join(', ')
    content_tag :span, message, 
      {class: 'error-description help-inline', data:{'field-error' => field}}
  end

  def notifications_count
    Notification.for_user(current_user).count
  end

  def notification_link(notification)
    resource = notification.from_type.underscore
    url = send("get_#{resource}_url", notification)
    raw link_to(notification.description, url)
  end

  private
  def get_message_url(notification)
    user_message_path(notification.to.login, notification.from_id)
  end

end


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

end

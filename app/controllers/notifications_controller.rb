class NotificationsController < ApplicationController

  def list
    @notifications = Notification.for_user(current_user).limit(10)
  end

  def not_read
    total = Notification.for_user(current_user).count
    render json: {total: total}
  end

end


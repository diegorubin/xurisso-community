class DashboardController < ApplicationController

  def index
    @events = Event.after(Time.now).order("start_at ASC").limit(3)
    @surveys = Survey.actives.order("created_at ASC")
  end

end

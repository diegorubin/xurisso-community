class EventsController < ApplicationController
  before_action :get_event, :only => [:show]

  def index
    respond_to do |format|

      format.html do
        @now = Time.now
      end

      format.json do
        now = Time.now
        now = Time.local(params[:year], params[:month]) if params[:month] && params[:year]

        calendar = {:days => [], 
                    :year => now.year, :month => now.month, 
                    :month_name => l(now, :format => :monthname, :locale => 'pt-BR') }

        offset = now.beginning_of_month.wday - 1
        offset += 7 unless offset >= 0

        # previous month
        last_month = (now - 1.month).end_of_month

        start_at = last_month - offset.days
        calendar[:days] += Range.new(start_at.day, last_month.day).collect{|d| d}

        # current month
        calendar[:days] += Range.new(now.beginning_of_month.day, now.end_of_month.day).collect{|d| d}

        # next month
        next_month = (now + 1.month).beginning_of_month

        end_at = next_month + (41 - calendar[:days].size).days
        calendar[:days] += Range.new(next_month.day, end_at.day).collect{|d| d}

        events = Event.between(start_at, end_at)
        calendar[:events] = {}

        events.each do |event|
          Range.new(event.start_at.day, event.end_at.day).each do |d|
            index = "#{event.start_at.month}-#{d}"
            calendar[:events][index] ||= []
            calendar[:events][index] << {:id => event.id,
                                         :title => event.title, 
                                         :category => event.category.title,
                                         :icon_name => event.category.icon_name,
                                         :description => event.description.gsub("\n", "<br/>")}
          end
        end

        users = User.birthdays_of_period(start_at, end_at)
        users.each do |user|
          index = "#{user.birthday.month}-#{user.birthday.day}"
          calendar[:events][index] ||= []
          calendar[:events][index] << {:title => "Aniversário de #{user.identifier}", 
                                       :category => "Aniversário",
                                       :icon_name => "icon-user",
                                       :description => "Mande seus parabéns para <a href='#{new_user_message_path(user.login)}?resp=Feliz Aniversário'>#{user.identifier}</a>"}
        end

        render :text => calendar.to_json, :content_type => "application/json"
      end
    end
  end

  def show
    respond_to do |format|
      format.html do
        render :action => :show
      end

      format.json do
        @event = Event.find(params[:id])
        @event.current_user_participating = current_user.events.include?(@event)
        render :json => @event
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        @event = Event.find(params[:id])
        if params[:join]
          @event.users << current_user
        elsif params[:exit]
          @event.users.delete(current_user)
        end
        render :json => @event.save
      end
    end
  end

  private
  def get_event
    @event = Event.find(params[:id])
  end

end

class Admin::EventsController < AdminController
  before_action :get_event, :only => [:show, :edit, :update, :destroy]
  before_action :get_categories, :only => [:edit, :update, :new, :create]

  def index
    @events = Event.page(params.fetch(:page,1))
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      flash[:notice] = "Evento criado com sucesso."
      redirect_to :action => :index
    else
      flash[:alert] = "Não foi possível criar o evento."
      render :action => :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Evento atualizado com sucesso."
      redirect_to :action => :index
    else
      flash[:alert] = "Não foi possível atualizar o evento."
      render :action => :edit
    end
  end

  def destroy

    if @event.destroy
      flash[:notice] = "Evento removido com sucesso."
    else
      flash[:alert] = "Não foi possível remover o evento."
    end

    redirect_to :action => :index
  end

  private
  def get_event
    @event = Event.find(params[:id])
  end

  def get_categories
    @categories = EventCategory.order("title ASC")
  end

  def event_params
    params.require(:event)
      .permit(:title, :description, :start_at, :end_at, :published,
              :event_category_id, :user_can_participate, :body)
  end

end


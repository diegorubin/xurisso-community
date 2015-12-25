class Admin::EventsController < AdminController
  before_filter :get_event, :only => [:show, :edit, :update, :destroy]
  before_filter :get_categories, :only => [:edit, :update, :new, :create]

  def index
    @events = Event.page(params.fetch(:page,1))
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
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
    if @event.update_attributes(params[:event])
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
    @categories = EventCategory.all(:order => "title ASC")
  end

end


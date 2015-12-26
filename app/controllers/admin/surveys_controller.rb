class Admin::SurveysController < AdminController

  before_filter :get_survey, :only => [:show, :edit, :update, :destroy]

  def index
    @surveys = Survey.order("active DESC, created_at DESC").
                      page(params.fetch(:page,1))
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)

    if @survey.save
      flash[:notice] = "Enquete criada com sucesso."
      redirect_to :action => :index
    else
      flash[:alert] = "Não foi possível criar a enquete."
      render :action => :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @survey.update(survey_params)
      flash[:notice] = "Enquete atualizada com sucesso."
      redirect_to :action => :index
    else
      flash[:alert] = "Não foi possível atualizar a enquete."
    end
  end

  def destroy

    if @survey.destroy
      flash[:notice] = "Enquete removido com sucesso."
    else
      flash[:alert] = "Não foi possível remover a enquete."
    end

    redirect_to :action => :index
  end

  private
  def get_survey
    @survey = Survey.find(params[:id])
  end

  def survey_params
    params.require(:survey)
      .permit(:title, :description, :start_at, :end_at, :active)
  end

end


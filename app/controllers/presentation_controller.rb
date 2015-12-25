class PresentationController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  def index
    render :layout => false
  end
end
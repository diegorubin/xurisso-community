class GroupsController < ApplicationController
  include FormResponse

  def index
    @groups = Group.for_user(current_user).order("title ASC")
  end

end


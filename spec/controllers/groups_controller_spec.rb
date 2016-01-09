require 'rails_helper'

describe GroupsController, type: :controller do
  login_user

  context 'on list groups' do

    it 'show list' do
      get :index
      expect(response).to be_success
    end

  end

end


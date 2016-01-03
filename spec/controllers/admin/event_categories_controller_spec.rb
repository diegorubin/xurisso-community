require 'rails_helper'

describe Admin::EventCategoriesController, type: :controller do
  login_admin

  let(:resource_created) {FactoryGirl.create(:event_category)}
  let(:resource_attributes) {FactoryGirl.attributes_for(:event_category)}
  let(:resource_attributes_invalid) {FactoryGirl.attributes_for(:event_category, title: '')}

  it_behaves_like "base controller"

end


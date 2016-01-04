require 'rails_helper'

describe Admin::EventCategoriesController, type: :controller do
  login_admin

  let(:resource) {:event_category}
  let(:resources) {:event_categories}
  let(:resource_created) {FactoryGirl.create(:event_category)}
  let(:resource_attributes) {FactoryGirl.attributes_for(:event_category)}
  let(:resource_attributes_invalid) {FactoryGirl.attributes_for(:event_category, title: '')}

  let(:valid_update) { {title: 'a new title'} }
  let(:invalid_update) { {title: ''} }

  it_behaves_like "base controller"

end


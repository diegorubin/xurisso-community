RSpec.shared_examples "base controller" do |parameter|


  context 'on list resources' do

    before(:each) {get :index}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable with list of resources' do
      expect(assigns(resources)).to be_kind_of(Mongoid::Criteria)
    end

  end

  context 'on form for new resource' do
    before(:each) {get :new}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable for new resource' do
      expect(assigns(resource)).to be_kind_of(resource)
    end
   
  end

  context 'on create resource' do


    it 'variable for new resource' do
      post :create, resource => resource_attributes
      expect(assigns(resource)).to be_kind_of(resource)
    end

    it 'save resource' do
      post :create, resource => resource_attributes
      expect(response).to be_redirect
    end

    it 'not save resource' do
      post :create, resource => resource_attributes_invalid
      expect(response).to be_success
    end

    context 'on result as json' do
      it 'save resource' do
        post :create, resource => resource_attributes, format: 'json'
        expect(response).to be_success
        expect(response.body).to be_kind_of(String)
      end

      it 'not save resource' do
        post :create, resource => resource_attributes_invalid, format: 'json'
        expect(response).to be_success
      end
    end

  end

  context 'on edit resource' do
    before(:each) {get :edit, :id => resource_created.id}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable for resource' do
      expect(assigns(resource)).to be_kind_of(resource)
      expect(assigns(resource)).to_not be_new_record
    end

  end

  context 'on update resource' do

    it 'variable for resource' do
      patch :update, :id => resource_created.id, resource => {}
      expect(assigns(resource)).to be_kind_of(resource)
      expect(assigns(resource)).to_not be_new_record
    end

    it 'save resource' do
      patch :update, :id => resource_created.id, resource => valid_update
      expect(response).to be_redirect
    end

    it 'not save resource' do
      patch :update, :id => resource_created.id, resource => invalid_update
      expect(response).to be_success
    end

  end

  context 'on show resource' do

    context 'on persisted' do
      before(:each) {get :show, :id => resource_created.id}
      it('render template') { expect(response).to be_success }
      it('variable for resource') { expect(assigns(resource)).to be_kind_of(resource) }
      it('resource saved') { expect(assigns(resource)).to_not be_new_record }
    end

    context 'on preview' do
      before(:each) {get :show, :id => 'preview'}
      it('render template') { expect(response).to be_success }
      it('variable for resource') { expect(assigns(resource)).to be_kind_of(resource) }
      it('resource not saved') { expect(assigns(resource)).to be_new_record }
    end
   
  end

  context 'on destroy resource' do

    it 'destroy object' do
      delete :destroy, :id => resource_created.id
      expect(response).to be_redirect
    end

  end

end


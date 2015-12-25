require 'spec_helper'

describe Chapter do
  it 'should create a chapter' do
    Chapter.new(Factory.attributes_for(:chapter)).save.should be_true
  end
end

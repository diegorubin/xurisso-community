require 'spec_helper'

describe Testament do
  it 'should create a testament' do
    Testament.new(FactoryGirl.attributes_for(:testament)).save.should be_true
  end
end

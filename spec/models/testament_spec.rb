require 'spec_helper'

describe Testament do
  it 'should create a testament' do
    Testament.new(Factory.attributes_for(:testament)).save.should be_true
  end
end

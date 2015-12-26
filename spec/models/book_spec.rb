require 'spec_helper'

describe Book do
  it 'should create a book' do
    Book.new(FactoryGirl.attributes_for(:book)).save.should be_true
  end
end

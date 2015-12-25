require 'spec_helper'

describe Versicle do
  it 'should create a versicle' do
    Versicle.new(Factory.attributes_for(:versicle)).save.should be_true
  end
end

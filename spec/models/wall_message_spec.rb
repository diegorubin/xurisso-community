require 'spec_helper'

describe WallMessage do
  context "on save wall message" do
    let(:wall_message_attributes) {attributes_for(:wall_message)}

    it "should dont save without a owner" do
      wall_message = WallMessage.new(wall_message_attributes)
      expect(wall_message.save).to be_falsey
    end

  end

  context "on recover" do

    let(:user) { create(:user) }
    let!(:wall_message) { create(:wall_message, :user => user) }

    it "should dont list blocked messages" do
      WallMessage.count.should == 1
      WallMessage.not_blocked.count.should == 1

      wall_message.update_attribute(:blocked, true)

      WallMessage.count.should == 1
      WallMessage.not_blocked.count.should == 0
    end

    it "should recover message of active users" do
      WallMessage.count.should == 1

      user.update_attribute(:removed, true)
      WallMessage.count.should == 0

      user.update_attribute(:removed, false)
      user.update_attribute(:blocked, true)
      WallMessage.count.should == 0
    end
  end

end


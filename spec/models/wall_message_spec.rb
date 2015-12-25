require 'spec_helper'

describe WallMessage do
  context "on save wall message" do
    before(:each) do
      @wall_message_attr = Factory.attributes_for(:wall_message)
    end

    it "should dont save without a owner" do
      @wall_message = WallMessage.new(@wall_message_attr)
      @wall_message.save.should_not be_true
    end

  end

  context "on recover" do
    before(:each) do
      @user = Factory(:user)
      @wall_message = Factory(:wall_message, :user => @user)
    end

    it "should dont list blocked messages" do
      WallMessage.count.should == 1
      WallMessage.not_blocked.count.should == 1

      @wall_message.update_attribute(:blocked, true)

      WallMessage.count.should == 1
      WallMessage.not_blocked.count.should == 0
    end

    it "should recover message of active users" do
      WallMessage.count.should == 1

      @user.update_attribute(:removed, true)
      WallMessage.count.should == 0

      @user.update_attribute(:removed, false)
      @user.update_attribute(:blocked, true)
      WallMessage.count.should == 0
    end
  end

end


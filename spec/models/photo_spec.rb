require 'spec_helper'

describe Photo do
  context "on recover comments" do
    it "should get all comments" do
      user = Factory(:user)
      photo = Factory(:photo)
      
      comment = Factory(:comment, :user => user, :commentable_id => photo.id)

      photo.comments.count.should == 1
    end

    it "should get only approved comments" do
      user = Factory(:user)
      photo = Factory(:photo)
      
      comment = Factory(:comment, :user => user, 
                        :commentable_id => photo.id,
                        :approved => true)

      comment = Factory(:comment, :user => user, 
                        :commentable_id => photo.id,
                        :approved => false)

      photo.approved_comments.count.should == 1

    end

  end
end

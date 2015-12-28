require 'rails_helper'

describe Photo do
  context "on recover comments" do
      
    let(:user) { create(:user) }
    let(:photo) { create(:photo) }
    let(:comment) { 
      create(:comment, :user => user, :commentable => photo) 
    }

    let(:comment_approved) {
      create(:comment, :user => user, 
        :commentable => photo, :approved => true)
    }

    let(:comment_not_approved) {
      create(:comment, :user => user, 
        :commentable => photo, :approved => false)
    }

    it "should get all comments" do
      comment
      expect(photo.comments.count).to eql 1
    end

    it "should get only approved comments" do
      comment_approved
      comment_not_approved
      expect(photo.approved_comments.count).to eql 1
    end

  end
end


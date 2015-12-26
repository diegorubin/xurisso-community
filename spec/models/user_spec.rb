require 'spec_helper'

describe User do

  context "on direct messages" do
    before(:each) do
      @fulano = FactoryGirl(:user)
      @ciclano = FactoryGirl(:user)
    end

    it "should change messages" do
      message = FactoryGirl(:message, :from => @fulano, :to => @ciclano)

      @ciclano.received_messages.first.should == message
      @fulano.sent_messages.first.should == message
    end

    it "should remove sent message" do
      message = FactoryGirl(:message, :from => @fulano, :to => @ciclano)

      @ciclano.received_messages.first.should == message
      @fulano.sent_messages.first.should == message

      message.removed_by_from = true
      message.save

      @ciclano.received_messages.count.should == 1
      @fulano.sent_messages.count.should == 0

    end

    it "should remove received message" do
      message = FactoryGirl(:message, :from => @fulano, :to => @ciclano)

      @ciclano.received_messages.first.should == message
      @fulano.sent_messages.first.should == message

      message.removed_by_to = true
      message.save

      @ciclano.received_messages.count.should == 0
      @fulano.sent_messages.count.should == 1

    end

  end

  context "on survey scope" do
    before(:each) do
      @current = FactoryGirl(:user)

      @survey = FactoryGirl(:survey)
      @options = []

      4.times do |i|
        @options << FactoryGirl(:survey_option, :survey => @survey, 
                                            :description => "opcao #{i}")
      end

    end

    it "should recover answer of survey" do
      FactoryGirl(:survey_answer, :survey_option => @options[1],
                                       :survey => @survey,
                                       :user => @current)

      @current.answer_of(@survey).should == @options[1]

    end

  end

end


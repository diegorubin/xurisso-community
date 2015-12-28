require 'rails_helper'

describe User do

  context "on direct messages" do

    let(:fulano) { create(:user) }
    let(:ciclano) { create(:user) }

    let!(:message) { create(:message, :from => fulano, :to => ciclano) }

    it "should change messages" do
      expect(ciclano.received_messages.first).to eql message
      expect(fulano.sent_messages.first).to eql message
    end

    it "should remove sent message" do
      expect(ciclano.received_messages.first).to eql message
      expect(fulano.sent_messages.first).to eql message

      message.removed_by_from = true
      message.save

      expect(ciclano.received_messages.count).to eql 1
      expect(fulano.sent_messages.count).to eql 0

    end

    it "should remove received message" do
      expect(ciclano.received_messages.first).to eql message
      expect(fulano.sent_messages.first).to eql message

      message.removed_by_to = true
      message.save

      expect(ciclano.received_messages.count).to eql 0
      expect(fulano.sent_messages.count).to eql 1
    end

  end

  context "on survey scope" do

    let(:current) { create(:user) }
    let(:survey) { create(:survey) }

    let(:options) do
      options = []
      4.times do |i|
        options << create(:survey_option, :survey => survey, 
          :description => "opcao #{i}")
      end
      options
    end

    it "should recover answer of survey" do
      create(:survey_answer, :survey_option => options[1],
        :survey => survey, :user => current)
      expect(current.answer_of(survey)).to eql options[1]
    end

  end

end


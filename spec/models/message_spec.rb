require 'spec_helper'

describe Message do

  context 'when create' do

    let(:message) { create(:message) }

    it 'notify receiver' do
      expect { message }.to change(Notification, :count).by(1)
    end

  end

end


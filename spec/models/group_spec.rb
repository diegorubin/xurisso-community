require 'rails_helper'

RSpec.describe Group, :type => :model do

  context 'on list groups' do
    let!(:public_group) { create(:group, is_private: false) }
    let!(:private_group) { create(:group, is_private: true) }
    let(:user) { create(:user) }

    context 'on list private groups' do

      it 'not list without permission' do
        expect(described_class.for_user(user).count).to eql(1)
      end

      it 'list if have permission' do
        create(:participation, user: user, group: private_group)
        expect(described_class.for_user(user).count).to eql(2)
      end

    end
  end

end

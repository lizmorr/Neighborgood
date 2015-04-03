require 'rails_helper'

RSpec.describe Neighborhood, type: :model do
  describe 'editable_by?' do
    context 'neighborhood user signed in' do
      it 'returns true' do
        user = FactoryGirl.create(:user)
        neighborhood = FactoryGirl.create(:neighborhood, user: user)
        expect(neighborhood.editable_by?(user)).to eq true
      end
    end
    context 'another user signed in' do
      it 'returns false' do
        user = FactoryGirl.create(:user)
        another_user = FactoryGirl.create(:user)
        neighborhood = FactoryGirl.create(:neighborhood, user: user)
        expect(neighborhood.editable_by?(another_user)).to eq false
      end
    end
  end
end
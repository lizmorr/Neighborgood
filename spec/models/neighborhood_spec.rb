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

  describe 'destroyable_by?' do
    context 'admin signed in' do
      it 'returns true' do
        admin = FactoryGirl.create(:admin_user)
        neighborhood = FactoryGirl.create(:neighborhood)
        expect(neighborhood.destroyable_by?(admin)).to eq true
      end
    end

    context 'user signed in' do
      it 'returns false' do
        user = FactoryGirl.create(:user)
        neighborhood = FactoryGirl.create(:neighborhood)
        expect(neighborhood.destroyable_by?(user)).to eq false
      end
    end
  end

  describe 'search' do
    context 'has search params' do
      it 'returns a search method' do
        FactoryGirl.create(:neighborhood, name: "hello")
        search = "hello"
        expect(Neighborhood.search(search)).to eq
        Neighborhood.where(["name ILIKE ?", "%hello%"])
      end
    end

    context 'has no search params' do
      it 'does not have search params' do
        FactoryGirl.create(:neighborhood)
        search = nil
        expect(Neighborhood.search(search)).to eq Neighborhood.all
      end
    end
  end
end

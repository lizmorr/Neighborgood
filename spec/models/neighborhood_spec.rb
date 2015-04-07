require 'rails_helper'

describe Neighborhood do
  it { should belong_to(:user) }
  it { should have_many(:reviews) }

  it { should validate_presence_of(:user) }

  it { should validate_presence_of(:name) }
  it { should_not have_valid(:name).when("G") }

  it { should validate_presence_of(:location) }
  it { should have_valid(:location).when("North") }
  it { should_not have_valid(:location).when(nil, "") }

  it { should have_valid(:description).when("jio") }
  it { should_not have_valid(:description).when("G") }

  it 'should validate uniqueness of neighborhood' do
    neighborhood = FactoryGirl.create(:neighborhood)
    neighborhood_2 = FactoryGirl.build(:neighborhood, name: neighborhood.name)

    expect { neighborhood_2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

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
        expect(Neighborhood.search(search)).
          to eq Neighborhood.where(["name ILIKE ?", "%hello%"])
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

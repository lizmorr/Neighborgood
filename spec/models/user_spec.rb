require 'rails_helper'

describe User do
  it { should have_many(:neighborhoods) }
  it { should have_many(:reviews) }
  it { should have_many(:votes) }

  it { should validate_presence_of(:role) }
  it { should have_valid(:role).when("admin") }
  it { should_not have_valid(:role).when("Guest") }

  it { should validate_presence_of(:username) }

  it 'should validate uniqueness of user' do
    user = FactoryGirl.create(:user)
    user_2 = FactoryGirl.build(:user, email: user.email)

    expect { user_2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe 'admin?' do
    context 'neighborhood user is an admin' do
      it 'returns true' do
        admin = FactoryGirl.create(:admin_user)
        expect(admin).to be_admin
      end
    end
    context 'neighborhood user is not an admin' do
      it 'returns false' do
        user = FactoryGirl.create(:user)
        expect(user).to_not be_admin
      end
    end
  end

  describe 'editable_by?' do
    context 'admin signed in' do
      it 'returns true' do
        admin = FactoryGirl.create(:admin_user)
        user = FactoryGirl.create(:user)
        expect(user.editable_by?(admin)).to eq true
      end
    end

    context 'user signed in' do
      it 'returns false' do
        user = FactoryGirl.create(:user)
        another_user = FactoryGirl.create(:user)
        expect(another_user.editable_by?(user)).to eq false
      end
    end
  end

  describe 'destroyable_by?' do
    context 'admin signed in' do
      it 'returns true' do
        admin = FactoryGirl.create(:admin_user)
        user = FactoryGirl.create(:user)
        expect(user.destroyable_by?(admin)).to eq true
      end
    end

    context 'user signed in' do
      it 'returns false' do
        user = FactoryGirl.create(:user)
        another_user = FactoryGirl.create(:user)
        expect(another_user.destroyable_by?(user)).to eq false
      end
    end
  end
end

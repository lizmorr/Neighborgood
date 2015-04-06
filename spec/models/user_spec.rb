require 'rails_helper'

RSpec.describe User, type: :model do
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

  describe 'set_admin' do
    context 'set user to admin' do
      it 'returns true' do
        user = FactoryGirl.create(:user)
        user.set_admin
        expect(user).to be_admin
      end
    end
  end
end

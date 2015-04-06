require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'admin?' do
    context 'neighborhood user is an admin' do
      it 'returns true' do
        user = FactoryGirl.create(:user, role: 'admin')
        expect(user.admin?).to eq true
      end
    end
    context 'neighborhood user is not an admin' do
      it 'returns false' do
        user = FactoryGirl.create(:user, role: 'member')
        expect(user.admin?).to eq false
      end
    end
  end

  describe 'set_admin' do
    context 'set user to admin' do
      it 'returns true' do
        user = FactoryGirl.create(:user)
        user.set_admin
        expect(user.admin?).to eq true
      end
    end
  end
end

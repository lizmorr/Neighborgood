require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'editable_by?' do
    context 'review user signed in' do
      it 'returns true' do
        user = FactoryGirl.create(:user)
        review = FactoryGirl.create(:review, user: user)
        expect(review.editable_by?(user)).to eq true
      end
    end
    context 'another user signed in' do
      it 'returns false' do
        user = FactoryGirl.create(:user)
        another_user = FactoryGirl.create(:user)
        review = FactoryGirl.create(:review, user: user)
        expect(review.editable_by?(another_user)).to eq false
      end
    end
  end
end

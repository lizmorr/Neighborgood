require 'rails_helper'

describe Review do
  it { should belong_to(:neighborhood) }
  it { should belong_to(:user) }
  it { should have_many(:votes) }

  it { should validate_presence_of(:neighborhood) }
  it { should validate_presence_of(:user) }

  it { should have_valid(:rating).when(1, 5) }
  it { should_not have_valid(:rating).when(6) }

  it { should have_valid(:description).when("This neighborhood is the best!!") }
  it { should_not have_valid(:description).when(nil, "", "hi", "d"*330) }

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

  describe 'deletable_by?' do
    context 'review user signed in' do
      it 'returns true' do
        user = FactoryGirl.create(:user)
        review = FactoryGirl.create(:review, user: user)
        expect(review.deletable_by?(user)).to eq true
      end
    end
    context 'admin signed in' do
      it 'returns false' do
        user = FactoryGirl.create(:user)
        admin = FactoryGirl.create(:admin_user)
        review = FactoryGirl.create(:review, user: user)
        expect(review.deletable_by?(admin)).to eq true
      end
    end
    context 'another user signed in' do
      it 'returns false' do
        user = FactoryGirl.create(:user)
        another_user = FactoryGirl.create(:user)
        review = FactoryGirl.create(:review, user: user)
        expect(review.deletable_by?(another_user)).to eq false
      end
    end
  end
end

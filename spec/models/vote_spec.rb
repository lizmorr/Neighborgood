require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:review) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:review) }
  it { should validate_presence_of(:user) }

  it { should have_valid(:value).when(-1, 0, 1) }
  it { should_not have_valid(:value).when(5) }

  it 'should validate uniqueness of vote scoped to user' do
    vote = FactoryGirl.create(:vote)
    second_vote = FactoryGirl.build(:vote, user: vote.user, review: vote.review)

    expect { second_vote.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe 'build_upvote' do
    context 'user is signed in and upvotes' do
      it 'returns 1' do
        review = FactoryGirl.create(:review)
        user = FactoryGirl.create(:user)
        expect(Vote.build_upvote(user, review).value).to eq 1
      end
    end
  end

  describe 'build_downvote' do
    context 'user is signed in and downvotes' do
      it 'returns -1' do
        review = FactoryGirl.create(:review)
        user = FactoryGirl.create(:user)
        expect(Vote.build_downvote(user, review).value).to eq -1
      end
    end
  end

  describe 'update_vote' do
    context 'user changes vote' do
      it 'returns -1' do
        vote = FactoryGirl.create(:vote, value: 0)
        vote.update_vote(-1)
        expect(vote.value).to eq -1
      end
    end
  end
end

class UpvotesController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @user = current_user
    @vote = Vote.build_upvote(@user, @review)

    if @vote.save
      redirect_to neighborhood_path(@review.neighborhood), notice: "Success!"
    end
  end

  def update
    @review = Review.find(params[:review_id])
    @user = current_user
    @vote = Vote.find_by(user_id: @user, review_id: @review)

    if @vote.update_vote(1)
      redirect_to neighborhood_path(@review.neighborhood), notice: "Success!"
    end
  end
end

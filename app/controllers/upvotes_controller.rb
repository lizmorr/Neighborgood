class UpvotesController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @user = current_user
    @vote = Vote.build_upvote(@user, @review)

    if @vote.save
      redirect_to neighborhood_path(@review.neighborhood), notice: "Upvoted!"
    end
  end
end

class VotesController < ApplicationController
  def update
    review = Review.find(params[:review_id])
    vote = review.votes.find(params[:id])
    vote.value = 0
    if vote.save
      redirect_to neighborhood_path(review.neighborhood),
        notice: "You have cancelled your vote."
    end
  end
end

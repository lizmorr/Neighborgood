class ReviewNotifier < ActionMailer::Base
  default from: "reviews@example.com"

  def new_review(review)
    @review = review

    mail(
      to: review.neighborhood.user.email,
      subject: "New Review added for #{review.neighborhood.name}"
    )
  end
end

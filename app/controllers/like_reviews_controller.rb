class LikeReviewsController < ApplicationController
  before_action :logged_in_user, :load_review

  def create
    @like = current_user.like_reviews.create like_review_params
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  def destroy
    @like = LikeReview.find_by id: params[:id]
    @like.destroy if @like
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  private
  def like_review_params
    params.require(:like_review).permit :review_id
  end

  def load_review
    @review = Review.find_by id: params[:like_review][:review_id]
  end
end

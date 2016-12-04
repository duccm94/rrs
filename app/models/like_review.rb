class LikeReview < ActiveRecord::Base
  include ActivityLog
  belongs_to :user
  belongs_to :review
  after_save :create_like_review_notification

  private
  def create_like_review_notification
    create_notification user_id, review.user.id, "like", review.id
  end
end

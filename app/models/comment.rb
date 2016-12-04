class Comment < ActiveRecord::Base
  include ActivityLog

  belongs_to :user
  belongs_to :review
  has_many :comments

  validates :content, presence: true

  after_save :create_comment_activity, :create_comment_notification

  scope :order_by_time, -> {order created_at: :desc}

  private
  def create_comment_activity
    create_activity user_id, review.book_id, Activity.target_types[:book_target],
      Activity.action_types[:commented]
  end

  def create_comment_notification
    create_notification user_id, review.user.id, "comment", review.id
  end
end

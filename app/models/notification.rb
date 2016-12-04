class Notification < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :review
  belongs_to :owner, class_name: User.name

  enum content: [:like, :comment, :follow]

  scope :order_by_time, -> {order created_at: :desc}

  def target
    if follow?
      owner
    elsif comment? || like?
      review
    end
  end

  def load_path
    if target
      return user_path(target) if follow?
      return restaurant_review_path(target.book, target) if like? || comment?
    else
      return I18n.t "model.activity.emptyurl"
    end
  end
end

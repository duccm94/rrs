class Activity < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  alias_attribute :owner, :user

  enum action_type: [:followed, :read, :reading, :favorite, :reviewed, :commented]
  enum target_type: [:user_target, :book_target, :review_target]

  belongs_to :user
  has_many :like_activities, dependent: :destroy

  def target
    if user_target?
      User.find_by id: target_id
    elsif book_target?
      Book.find_by id: target_id
    elsif review_target?
      Review.find_by id: target_id
    end
  end

  def target_name
    if target
      return target.name if user_target?
      return target.title if book_target?
      return target.class.to_s if review_target?
    else
      return I18n.t "model.activity.banned" if user_target?
      return I18n.t "model.activity.deleted" if book_target? || review_target?
    end
  end

  def target_path
    if target
      return user_path(target) if user_target?
      return restaurant_path(target) if book_target?
      return restaurant_review_path(target.book, target) if review_target?
    else
      return I18n.t "model.activity.emptyurl"
    end
  end

  def message
    return I18n.t "model.activity.message.follow" if followed?
    return I18n.t "model.activity.message.read" if read?
    return I18n.t "model.activity.message.reading" if reading?
    return I18n.t "model.activity.message.favorite" if favorite?
    return I18n.t "model.activity.message.review" if reviewed?
    return I18n.t "model.activity.message.comment" if commented?
  end
end

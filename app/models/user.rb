class User < ActiveRecord::Base
  attr_accessor :remember_token
  ratyrate_rater

  has_many :marks
  has_many :requests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :like_activities, dependent: :destroy
  has_many :like_books, dependent: :destroy
  has_many :like_reviews, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :passive_notifications, class_name: Notification.name,
    foreign_key: "recipient_id", dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true,
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  validate :avatar_size

  before_save :downcase_email

  has_secure_password

  scope :not_is_admin, ->{where is_admin: false}
  scope :order_by_name, ->{order name: :ASC}

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def downcase_email
    self.email = email.downcase
  end

  def is_user? current_user
    self == current_user
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def like_activity? activity
    like_activities.find_by(activity_id: activity.id).present?
  end

  def like_book? book
    like_books.find_by(book_id: book.id).present?
  end

  def like_review? review
    like_reviews.find_by(review_id: review.id).present?
  end

  def self.search name
    if name.present?
      where("name LIKE ?", "%#{name}%").order_by_name
    else
      order_by_name
    end

  end

  private
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, t("views.users.avatar.size"))
    end
  end
end

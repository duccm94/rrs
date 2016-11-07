class Review < ActiveRecord::Base
  include ActivityLog
  belongs_to :book
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :like_reviews, dependent: :destroy
  has_attached_file :image, styles: {medium: "300x300", large: "450x450#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :content, presence: true
  after_save :calculate_score, :create_review_activity

  validates :rating, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  scope :order_by_time, -> {order created_at: :desc}
  scope :order_by_rating, -> {order rating: :desc}
  scope :top_review, -> book {where(book: book)}
  private
  def calculate_score
    sum = book.reviews.reduce(0) {|sum, element| sum + element.rating}
    average_score = sum / book.reviews.count
    book.update_attribute :rate_score, average_score
  end

  def create_review_activity
    create_activity user_id, book_id, Activity.target_types[:book_target],
      Activity.action_types[:reviewed]
  end
end

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
    # :calculate_score_place, :calculate_score_service, :calculate_score_food, :calculate_score_price

  validates :rating, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  validates :rating_place, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  validates :rating_service, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  validates :rating_food, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  validates :rating_price, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5}

  scope :order_by_time, -> {order created_at: :desc}
  scope :order_by_rating, -> {order rating: :desc}
  scope :top_review, -> book {where(book: book)}
  private

  def calculate_score
    sum_rating = 0
    sum_rating_place = 0
    sum_rating_service = 0
    sum_rating_food = 0
    sum_rating_price = 0
    count = book.reviews.count
    book.reviews.reduce(0)  do |sum, element|
      sum_rating = sum_rating + element.rating
      sum_rating_place = sum_rating_place + element.rating_place
      sum_rating_service = sum_rating_service + element.rating_service
      sum_rating_food = sum_rating_food + element.rating_food
      sum_rating_price = sum_rating_price + element.rating_price
    end
    book.update_attributes rate_score: sum_rating/count,
      rate_place: sum_rating_place/count, rate_service: sum_rating_service/count,
      rate_food: sum_rating_food/count, rate_price: sum_rating_price/count
  end
  def calculate_scorea
    sum = book.reviews.reduce(0) {|sum, element| sum + element.rating}
    average_score = sum / book.reviews.count
    book.update_attribute :rate_score, average_score
  end

  def create_review_activity
    create_activity user_id, book_id, Activity.target_types[:book_target],
      Activity.action_types[:reviewed]
  end
end

class Book < ActiveRecord::Base
  belongs_to :category
  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  ratyrate_rateable "rate"
  # mount_uploader :image, BookImageUploader
  has_attached_file :image, styles: {medium: "300x300", large: "450x450#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :title, presence: true, length: {maximum: 50}
  validates :author, presence: true, length: {maximum: 50}

  Mark.mark_types.keys.each do |name|
    scope :"#{name}_books",
    ->(user){where(id: Mark.send(name).where(user_id: user.id).pluck(:book_id))}
  end

  def self.search(search, rate)
    if search.present? && rate.present?
      joins(:category).where("(books.title LIKE :getsearch
        OR books.author LIKE :getsearch
        OR categories.title LIKE :getsearch)
        AND books.rate_score >= :rate",
        getsearch: "%#{search}%", rate: rate)
    elsif search.present? || rate.present?
      if search.blank?
        where("rate_score >= ?", rate)
      else
        joins(:category).where("books.title LIKE :getsearch
          OR books.author LIKE :getsearch
          OR categories.title LIKE :getsearch",
          getsearch: "%#{search}%")
      end
    else
      all
    end
  end

end

class Category < ActiveRecord::Base
  has_many :books, dependent: :destroy
  validates :title, presence: true, uniqueness: true
end

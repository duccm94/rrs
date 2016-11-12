class Request < ActiveRecord::Base
  belongs_to :user
  validates :book_title, presence: true
  validates :book_author, presence: true

  enum accept: [:waiting, :accept, :reject]
end

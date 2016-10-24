class Mark < ActiveRecord::Base
  include ActivityLog
  enum mark_type: [:visting, :visted, :favorite]
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true

  after_save :create_mark_activity

  mark_types.keys.each do |mark_name|
    scope :mark_name, ->{where mark_type: Settings.send(mark_name)}
  end

  private
  def create_mark_activity
    create_activity user_id, book_id, Activity.target_types[:book_target],
      Activity.action_types[mark_type]
  end
end

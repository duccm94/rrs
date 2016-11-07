class Request < ActiveRecord::Base
  belongs_to :user

  enum accept: [:waiting, :accept, :reject]
end

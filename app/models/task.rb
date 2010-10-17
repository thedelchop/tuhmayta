class Task < ActiveRecord::Base
  belongs_to :user

  attr_accessible :name, :user_id, :user

  validates :name, :presence => true

  validates :user_id, :presence => true
end

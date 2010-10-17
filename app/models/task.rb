class Task < ActiveRecord::Base
  belongs_to :user

  attr_accessible :name, :user_id, :user, :estimate

  validates :name, :presence => true

  validates :estimate, :presence => true, 
                       :numericality => {:greater_than => 0, :less_than => 6}

  validates :user_id, :presence => true
end

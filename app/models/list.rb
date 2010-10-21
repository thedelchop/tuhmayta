class List < ActiveRecord::Base
  has_many :list_tasks
  has_many :tasks, :through => :list_tasks

  belongs_to :user

  attr_accessible :name, :user_id

  validates :name, :presence => true, 
                   :uniqueness => {:scope => :user_id}

  validates :user_id, :presence => true
end

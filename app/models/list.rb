class List < ActiveRecord::Base
  has_many :list_tasks
  has_many :tasks, :through => :list_tasks

  belongs_to :user

  attr_accessible :name, :user_id, :list_tasks

  validates :name, :presence => true, 
                   :uniqueness => {:scope => :user_id}

  validates :user_id, :presence => true

  def to_param
    name
  end
    
  def expired?
    self.updated_at < 1.day.ago
  end

  def tasks
    #return all of the tasks associated with this list, sorted by postion.
    self.list_tasks.order('position ASC').collect{|list_task| list_task.task}
  end
end

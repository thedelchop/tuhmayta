class ListTask < ActiveRecord::Base
  belongs_to :task
  belongs_to :list

  attr_accessible :task_id, :position,:list_id

  validates :task_id, :presence => true, :uniqueness => {:scope => :list_id}

  validates :position, :presence => true, :uniqueness => {:scope => :list_id}

  validates :list_id, :presence => true
end

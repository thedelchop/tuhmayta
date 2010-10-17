class ListTask < ActiveRecord::Base
  belongs_to :task
  belongs_to :list

  attr_accessible :task_id, :position,:list_id
end

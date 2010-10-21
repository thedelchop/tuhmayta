class Task < ActiveRecord::Base
  after_create :append_to_master_list
  
  acts_as_taggable

  belongs_to :user
  has_many :pomodoros

  attr_accessible :name, :user_id, :user, :estimate, :urgent, :tag_list

  validates :name, :presence => true

  validates :estimate, :presence => true, 
                       :numericality => {:greater_than => 0, :less_than => 6}

  validates :user_id, :presence => true
   
  def append_to_master_list
    
    current_user = User.find(self.user_id)

    # Create a new list_task entry for this task
    ListTask.create(:task_id => self.id, :list_id => current_user.master_list.id, :position => current_user.master_list.tasks.count + 1)
   
    # If the task is urgent then we also need to add it to the current_list
    if self.urgent? 
      ListTask.create(:task_id => self.id, :list_id => current_user.current_list.id, :position => current_user.current_list.tasks.count + 1)
    end
  end
end

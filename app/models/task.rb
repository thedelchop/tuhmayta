class Task < ActiveRecord::Base
  after_create :append_to_master_list
  
  acts_as_taggable

  belongs_to :user
  has_many :pomodoros

  attr_accessible :name, :user_id, :user, :estimate, :urgent

  validates :name, :presence => true

  validates :estimate, :presence => true, 
                       :numericality => {:greater_than => 0, :less_than => 6}

  validates :user_id, :presence => true
   
  def append_to_master_list
    # Create a new list_task entry for this task
    ListTask.create(:task_id => self.id, :list_id => User.find(self.user_id).master_list.id)
  end
end

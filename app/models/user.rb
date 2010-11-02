class User < ActiveRecord::Base
  
  after_create do
    # Create a new instance of settings so that the user
    # will have a settings instance available to him/her
    Settings.create(:user_id => self.id)

    self.setup_lists
  end

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :tasks

  # has_one :current_list, :class_name => "List", :conditions => {:name => "current"}

  has_one :master_list, :class_name => "List", :conditions => {:name => "master"}

  has_one :settings

  DAY_IN_SECS = 86400

  def current_list
    # return the current list, and check to see if its more than 24 hours old
    current_list = List.where(:user_id => self.id, :name => "current").first
    if Time.now <=> current_list.updated_at + DAY_IN_SECS
      # If so, delete the current list and create a new list
      current_list.list_tasks.destroy

      @tasks = self.master_list.list_tasks.order('position ASC').collect{|list_task| list_task.task}

      total_pomodoros = self.settings.day_length

      itr = 0

      while(total_pomodoros > 0)
        current_task = tasks[itr]
        unless current_task.complete?
          ListTask.create(:list_id => current_list.id, :task_id => current_task.id)
          total_pomodoros -= current_task.estimate - current_task.pomodoros.count
          itr += 1
        end
      end
   
    #Return the current list 
    end
    current_list
  end

  def setup_lists
    #Create a master and a curent task list for the user when the 
    #user is created
    List.create(:name => "master", :user_id => self.id)
    List.create(:name => "current", :user_id => self.id)
  end
end

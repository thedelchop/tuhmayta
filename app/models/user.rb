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

  has_one :master_list, :class_name => "List", :conditions => {:name => "master"}

  has_one :settings


  def current_list
    # return the current list, and check to see if its more than 24 hours old
    
    current_list = List.where(:user_id => self.id, :name => "current").first
    
    if current_list.expired?
      # If so, delete the current list and create a new list
      current_list.list_tasks.destroy

      tasks = self.master_list.tasks

      return current_list if tasks.empty?

      user_pomodoros_day = self.settings.day_length

      master_list_pomodoros = 0

      #Check to see if the master list has enough pomodoros to fill the current list

      tasks.each {|task| master_list_pomodoros += task.pomodoros_remaining}
     
      itr = 0

      # # if the master list is shorter than the 
      # if master_list_pomodoros < user_pomodoros_day 
      # else
      #   while(user_pomodoros_day <=> 0)
      #     current_task = tasks[itr]
      #     unless current_task.complete?
      #       ListTask.create(:list_id => current_list.id, :task_id => current_task.id)
      #       user_pomodoros_day -= current_task.pomodoros_remaining
      #       itr += 1
      #     end
      #   end 
      # end
    end
    
    #Return the current list 
    current_list
  end

  def setup_lists
    #Create a master and a curent task list for the user when the 
    #user is created
    List.create(:name => "master", :user_id => self.id)
    List.create(:name => "current", :user_id => self.id)
  end
end

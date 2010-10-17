class User < ActiveRecord::Base
  after_create :setup_lists

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :tasks

  has_one :current_list, :class_name => "List", :conditions => {:name => "current"}

  has_one :master_list, :class_name => "List", :conditions => {:name => "master"}

  has_one :setting

  def setup_lists
    List.create(:user_id => self.id, :name => "current")
    List.create(:user_id => self.id, :name => "master")
  end
end

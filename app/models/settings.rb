class Settings < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :presence => true,
                      :uniqueness => true
  
  attr_accessible :pomodoro_time, :rest_time, :user_id, :long_rest_interval
end

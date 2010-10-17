class Settings < ActiveRecord::Base
  belongs_to :user

  attr_accessible :pomodoro_time, :rest_time, :user
end

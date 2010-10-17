class Distraction < ActiveRecord::Base
  belongs_to :pomodoro

  attr_accessible :type

end

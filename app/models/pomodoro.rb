class Pomodoro < ActiveRecord::Base
  has_many :distractions, :autosave => true
  belongs_to :task, :dependent => :destroy

  attr_accessible :distractions, :void, :task
end


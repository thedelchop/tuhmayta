Factory.define :task do |task|
  task.name                  "TestTask"
  task.estimate               3
  task.association            :user
end


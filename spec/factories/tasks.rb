Factory.define :task do |task|
  task.name                  "TestTask"
  task.association            :user
end


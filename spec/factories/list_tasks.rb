Factory.define :list_task do |list_task|
  list_task.association :task
  list_task.list        {|list_task| Factory(:list, :user => list_task.task.user)} 
  list_task.sequence(:position)  {|n| n}
end

Factory.define :master_list_task, :parent => :list_task do |list_task|
  list_task.association :task
  list_task.list {|list_task| list_task.task.user.master_list}
end

Factory.define :current_list_task, :parent => :list_task do |list_task|
  list_task.association :task
  list_task.list {|list_task| list_task.task.user.current_list}
end

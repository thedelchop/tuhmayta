And 'I enter "$name" for the task name' do |name|
  fill_in('task[name]', :with => name)
end

And 'I estimate this task will take $estimate Pomodoros' do |estimate|
  select('4', :from => 'task[estimate]')
end

And 'I have the following tasks:' do |tasks_table|
  tasks_table.hashes.each do |hash|
    Factory(:task, :name => hash[:name], :estimate => hash[:estimate], :user_id => @user.id)
  end
end

And 'I tag this task with "$tags"' do |tags|
  fill_in('task[tags]', :with => tags)
end

Then 'I should see "$task_name" in my $list_type list of tasks' do |task_name, list_type|
  within("ul##{list_type}-list")do
    page.should have_content(task_name)
  end
end

Then 'I should not see "$task_name" in my $list_type list of tasks' do |task_name, list_type|
  within("ul##{list_type}-list")do
    page.should have_no_content(task_name)
  end
end

When 'I press "$action" for "$task_name"' do |action, task_name|
  task = Task.find_by_name(task_name)

  within("li#task_#{task.id}") do
    find(".#{action.downcase}_button").click
  end
end

When 'I drag the task "$task_name" to my current task list' do |task_name|
  task = Task.find_by_name(task_name)
  find("li#task_#{task.id}").drag_to("ul#current_list")
end

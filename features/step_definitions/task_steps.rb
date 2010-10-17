And 'I enter "$name" for the task name' do |name|
  fill_in('task[name]', :with => name)
end

And 'I estimate this task will take $estimate Pomodoros' do |estimate|
  select('4', :from => 'task[estimate]')

end

And 'I tag this task with "$tags"' do |tags|
  fill_in('task[tags]', :with => tags)
end

Then 'I should see "$task_name" in my list of tasks' do |$task_name|
  within("#master-list")do
    page.should have_content(task-name)
  end
end

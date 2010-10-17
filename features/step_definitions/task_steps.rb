And 'I enter "$name" for the task name' do |name|
  fill_in('task[name]', :with => name)
end

And 'I estimate this task will take $estimate Pomodoros' do |estimate|
  select('4', :from => 'task[estimate]')

end

And 'I tag this task with "$tags"' do |tags|
  fill_in('task[tags]', :with => tags)
end

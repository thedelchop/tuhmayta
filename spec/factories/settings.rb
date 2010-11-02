Factory.define :settings do |settings|
  settings.pomodoro_time 25
  settings.rest_time  5
  settings.long_rest_interval 4
  settings.association :user
end

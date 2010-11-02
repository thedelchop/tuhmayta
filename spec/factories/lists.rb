# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :list do |list|
  list.name        "test"
  list.association :user
end

Factory.define :master_list, :parent => :list do |master_list|
 master_list.name "master"
end

Factory.define :current_list, :parent => :list do |current_list|
 current_list.name "current"
end

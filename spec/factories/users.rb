Factory.define :user do |user|
    user.sequence(:email) {|n| "TestMan#{n}@example.com"}
    user.password               "secret"
end

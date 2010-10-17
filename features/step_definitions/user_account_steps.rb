def login(user)
  visit_path_to('the_login_page')
  fill_in("Email", :with => user.email)
  fill_in("Password", :with => user.password)
  click_button("Sign in")
end

Given 'I am a user with the email, "$email"' do |email|
  @user = Factory(:user, :email => email)
end


And 'I already have a Tuhmayta account' do
  User.find_by_email(@user.email).should_not be_nil
end
  
Given 'the user, "$email", already exists' do |email|
  Factory(:user, :email => email)
end

Then /^I should be able to edit (.+)$/ do |page_name|
  current_path = URI.parse(current_url).select(:path, :query).compact.join('?')
  current_path.should == path_to(page_name)
end

Given /^I edit my email address/ do
  click_link("Edit")
  fill_in(:email, :with => "TestMan1@example.com")
  click_button("Update")  
end

When /I fill out the registration form */ do
  fill_in("Email", :with => "New.User@example.com")
  fill_in("Password", :with => "secret")
  fill_in("Password confirmation", :with => "secret")
end

Given 'I am a registered Tuhmayta user with the email, "$email"' do |email|
  Given "I am a user with the email, \"#{email}\""
end

When /^I login/ do
  visit('users/sign_in')
  fill_in('Email', :with => @user.email)
  fill_in('Password', :with => @user.password)
  click_button('Sign in')
end

When 'I sign in' do
  When "I login"
end

Given /^I am not authenticated/ do
  visit('users/sign_out')
end

Given /^I am not signed in/ do
  visit('users/sign_out')
end

When /^I logout/ do
  click_link('Log Out')
end



Given(/^I am on the "(.*?)" page$/) do |page_name|
  case page_name
  when "signup"
    visit signup_path
  when "signin"
    visit signin_path
  else
    raise "Unknown page!"
  end
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I press "(.*?)"$/) do |btn|
  click_button btn
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end

Given(/^I created account$/) do
  FactoryGirl.create(:user)
end

When(/^I fill in Email with my email$/) do
  fill_in "Email", with: FactoryGirl.attributes_for(:user)[:email]
end

When(/^I fill in Password with my password$/) do
  fill_in "Password", with: FactoryGirl.attributes_for(:user)[:password]
end

Then(/^I should be on my page$/) do
  expect(page.current_path).to eq(user_path(User.last))
end

Then(/^I should be on the "(.*?)" page$/) do |page_name|
  case page_name
  when "signin"
    expect(page.current_path).to eq(signin_path)
  else
    raise "Unknown page!"
  end
end

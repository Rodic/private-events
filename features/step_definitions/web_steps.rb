
Given(/^I (?:am on|visit) the "(.*?)" page$/) do |page_name|
  case page_name
  when "signup"
    visit signup_path
  when "signin"
    visit signin_path
  when "new event"
    visit new_user_event_path(User.last)
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

Given(/^I am logged$/) do
  step 'I created account'
  step 'I am on the "signin" page'
  step 'I fill in Email with my email'
  step 'I fill in Password with my password'
  step 'I press "Submit"'
end

Given(/^I created followning events:$/) do |table|
  table.raw.each do | row |
    title, location, week = row
    User.last.events.create(title: title, location: location, date: week.to_i.week.from_now)
  end
end

When(/^I visit my page$/) do
  visit user_path(User.last)
end


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
    User.last.events.create!(title: title, location: location, date: week.to_i.week.from_now)
  end
end

When(/^I visit my page$/) do
  visit user_path(User.last)
end

Given(/^I have created an event$/) do
  User.last.events.create(FactoryGirl.attributes_for(:event))
end

Given(/^I added following users:$/) do |table|
  table.raw.each do |row|
    u = User.create(email: row[0], password: "supersecret", password_confirmation: "supersecret")
    Event.last.attendees << u
  end
end

When(/^I visit event page$/) do
  visit event_path(Event.last)
end

Then(/^I should see following users:$/) do |table|
  table.raw.each do |row|
    expect(page).to have_content(row[0])
  end
end

Given(/^I am invited to following events:$/) do |table|
  table.raw.each do |row|
    title, location, date = row
    e = Event.new(title: title, location: location, date: date.to_i.week.from_now)
    User.last.attended_events << e
  end
end

Given(/^user "(.*?)" exists$/) do |email|
  FactoryGirl.create(:user, email: email)
end

Given(/^I created event "(.*?)"$/) do |title|
  user = FactoryGirl.create(:user)
  user.events.create(title: title, location: "my place", date: 1.week.from_now)
end

When(/^I visit the "(.*?)" event page$/) do |title|
  visit event_path(Event.find_by_title(title))
end

Then(/^user "(.*?)" should have invitation to "(.*?)"$/) do |email, title|
  expect(User.find_by_email(email).invitations.last.event.title).to eq(title)
end

Given(/^I am invited to "(.*?)"$/) do |title|
  event = FactoryGirl.create(:event, title: title)
  event.invitations.create(recipient_id: User.last.id)
end

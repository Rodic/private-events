
Given(/^I am on the "(.*?)" page$/) do |page_name|
  case page_name
  when "signup"
    visit signup_path
  else
    raise "Unknown page"
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

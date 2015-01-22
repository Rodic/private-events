Feature: Create an event
  As a user
  So that I can spend fun time with other users
  I want to be able to creat events

  Scenario: Successfull event creations
    Given I am logged
    When I visit the "new event" page
    And I fill in "Title" with "My birthday"
    And I fill in "Location" with "My place"
    And I fill in "Date" with "2025-01-19 20:00:00"
    And I fill in "Description" with "You're notified on time!"
    And I press "Submit"
    Then I should be on my page
    And I should see "My birthday"

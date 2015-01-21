Feature: User registration
  As user
  In order to use website
  I want be able to register

  Scenario: Successfull registration
    Given I am on the "signup" page
    When I fill in "Email" with "user@private-events.com"
    And I fill in "Password" with "supersecret"
    And I fill in "Password confirmation" with "supersecret"
    And I press "Submit"
    Then I should see "Registration has been successfull"

  Scenario: Unsuccessfull registration
    Given I am on the "signup" page
    When I fill in "Email" with "user@private-events.com"
    And I fill in "Password" with "supersecret"
    And I fill in "Password confirmation" with "secret"
    And I press "Submit"
    Then I should see "Registration failed!"

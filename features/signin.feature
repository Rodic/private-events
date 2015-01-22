Feature: Sign in
  As user
  In order to use the website
  I want to be able to sign in

  Scenario: Successfull sign in
    Given I created account
    And I am on the "signin" page
    When I fill in Email with my email
    And I fill in Password with my password
    And I press "Submit"
    Then I should be on my page
    And I should see "Welcome back"

  Scenario: Unsuccessfull sign in
    Given I created account
    And I am on the "signin" page
    When I fill in Email with my email
    And I fill in "Password" with "wrong password"
    And I press "Submit"
    Then I should be on the "signin" page
    And I should see "Wrong email/password combination!"

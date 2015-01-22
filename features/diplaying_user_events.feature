Feature: Display user events
  As user
  In order to manage my events
  I want to be able to see them when I visit my profile page

  Scenario: List events
    Given I am logged
    And I created followning events:
      # title            | location | week from now |
      | Birthday party   | my place | 1             |
      | Basketball night | caffe    | 2             |
    When I visit my page
    Then I should see "Birthday party"
    And I should see "my place"
    And I should see "7 days"
    And I should see "Basketball night"
    And I should see "caffe"
    And I should see "14 days"

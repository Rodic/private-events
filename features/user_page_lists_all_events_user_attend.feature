Feature: Display all events user attend
  As an attendee
  So that I can keep track of events I should visit
  I want to see them when I visit my profile page

  Scenario: List events
    Given I am logged
    And I am invited to following events:
      # title            | location      | week from now |
      | Birthday party   | joe's place   | 1             |
      | Basketball night | local pub     | 2             |
    When I visit my page
    Then I should see "Birthday party"
    And I should see "joe's place"
    And I should see "Basketball night"
    And I should see "local pub"

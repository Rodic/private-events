Feature: User invitations
  As event creator
  I want to be able to invite other users to my events
  So that my event can have attendees

  Scenario: Invite existing users on already created event
    Given user "invite@me.com" exists
    And I created event "Birthday party"
    When I visit the "Birthday party" event page
    And I fill in "Send invitation to" with "invite@me.com"
    And I press "Send"
    Then I should see "You have invited invite@me.com"
    And user "invite@me.com" should have invitation to "Birthday party"

  Scenario: Invite non-existing users on already created event
    Given I created event "Birthday party"
    When I visit the "Birthday party" event page
    And I fill in "Send invitation to" with "invite@me.com"
    And I press "Send"
    Then I should see "There is no user with email invite@me.com"

  Scenario: User should see invitations on his profile page
    Given I am logged
    And I am invited to "Super boring event"
    When I visit my page 
    Then I should see "Super boring event"

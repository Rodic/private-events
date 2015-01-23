Feature: Event page lists all attendees
  As an event creator
  So that I can manage my events
  I want to see all attendees when I visit event page

  Scenario: List events
    Given I am logged
    And I have created an event
    And I added following users:
      | morris@gottlieblebsack.com          |
      | marlon@ullrich.biz                  |
      | kimberly@dietrich.com               |
      | brendan@klein.org                   |
      | terry@ruel.info                     |
      | jerry.pacocha@jerdeleffler.org      |
      | marcelina@wisozk.net                |
      | domenick.murray@zboncakreinger.info |
      | dena@skiles.com                     |
      | javier@borerdoyle.net               |
    When I visit event page
    Then I should see following users:
      | morris@gottlieblebsack.com          |
      | marlon@ullrich.biz                  |
      | kimberly@dietrich.com               |
      | brendan@klein.org                   |
      | terry@ruel.info                     |
      | jerry.pacocha@jerdeleffler.org      |
      | marcelina@wisozk.net                |
      | domenick.murray@zboncakreinger.info |
      | dena@skiles.com                     |
      | javier@borerdoyle.net               |


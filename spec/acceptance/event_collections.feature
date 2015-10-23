Feature: Collecting an event
  Background:
    Given there is no event collected

  Scenario: an event is sent to be collected
    When a remote client sends an event of type "send" and email type "Foo"
    And I go to the stats page
    Then the e-mails sent counter is "1"
    And the clicks counter is "0"
    And the e-mails opened counter is "0"

Feature: Peer Rate Reviews

  In order to contribute to the quality of the company scores
  As a contributor ot the site
  I want to leave peer ratings on reviews
  
  Scenario: Contributor browses reviews and leaves peer ratings
  
    Given I am logged in as a contributor user
    
    Given an activated contributor user named "Bob"
    And a company named "NoodleCo"
    Given a review with these attributes:
      | user      | Bob                       |
      | company   | Company_A                 |
      | issues    | Issue_A, Issue_B          |
      | rating    | 4                         |
      | body      | review body text          |
      | status    | published                 |
    When I go to the reviews page
    
    Then I should see "vote down"
    
    When I follow "vote down"
    
    Then I should see "feedback given"
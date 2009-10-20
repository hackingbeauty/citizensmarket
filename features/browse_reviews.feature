Feature:  Browse Reviews
  
  In order to find out what others are saying about companies
  As a visitor to the site (not logged in)
  I want to browse and read reviews
  
  Scenario:  Visitor browses reviews
    Given I am not logged in
    Given a review with these attributes:
      | user      | bob                       |
      | company   | Company_A                 |
      | issues    | Issue_A, Issue_B          |
      | rating    | 4                         |
      | body      | review body text          |
      | status    | published                 |
    When I go to the reviews page
    Then I should see "Company_A"
      And I should see "review body text"
      And I should see "bob@citizensmarket.org"
      And I should see a fixed star rating
      And I should see "Issue_A"
      And I should see "Issue_B"
      And I should not see "delete this review"
      
  
  Scenario:  Admin browses reviews and can delete them
    Given I am logged in as an admin user
    Given a review with these attributes:
      | user      | bob                       |
      | company   | Company_A                 |
      | issues    | Issue_A, Issue_B          |
      | rating    | 4                         |
      | body      | review body text          |
      | status    | published                 |
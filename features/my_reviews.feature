Feature: My Reviews

  In order to be more productive as a review-writing contributor
  As a contributor
  I want to skim over my reviews and see how they are doing, edit saved drafts, publish them 
  
  
  Scenario: Contributor visits My Reviews and deletes a draft
    Given I am logged in as a contributor user
    Given a typical draft review
    And a typical published review
    
    When I go to the my_reviews page
    Then I should see "My Reviews"
    And I should see "New Review"
    And I should see "typical review body"
    
    And I should see "draft"
    And I should see "published"
    And I should see "edit"
  
  @focus  
  Scenario: Contributor fills out review form and submits it
    Given I am logged in as a contributor user
    Given a company named "NoodleCo"
    And an issue named "Noodles"
    When I go to the new_review page
    
    Then I should see a form
    When I fill in the following:
  		| company 				        | NoodleCo	    |
  		| rating                  | 5             |
  		| body        		        | review body		|
    And I pick "Noodles" as the review issue
    And I press "Save"
    
    Then I should see "success"
    And I should see "review body"
    And I should see "draft"
    And I should see "publish"
    
    When I follow "publish"
    Then I should see "success"
    And I should see "review body"
    And I should see "published"
    
    
  
    
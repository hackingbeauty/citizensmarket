Feature:  Manage Issues

	In order to keep a regular, relevant set of issues
	As an admin user
	I want to administer issues and other details
	
  
	Scenario: Issues exist
	  Given an issue named "Monkey Politics"
	  And an issue named "Bat Politics"
	  When I go to the issues page
	  Then I should see "Monkey Politics"
	  And I should see "Bat Politics"
	  
	Scenario: Admins creates an issue
		Given I am logged in as an admin user
		When I go to the homepage
		Then I should see "Add an Issue"
		When I follow "Add an Issue"
		Then I should see a form
		When I fill in the following:
		  | Name          | IssueName         |
		  | Description   | IssueDescription  |
		  | Category      | IssueCategory     |
		And I press "Create"
		When I go to the issues page
		Then I should see "IssueName"
	
	
	Scenario: Admin edits an issue
	  Given I am logged in as an admin user
	  Given an issue named "IssueName"
	  When I go to the issues page
	  And I follow "IssueName"
	  Then I should see "Edit"
	  When I follow "Edit"
	  Then I should see a form
	  When I fill in the following:
	    | Name        | Monkey Barfights  |
	    | Description | Simian Knockouts  |
	    | Category    | Apeness           |
	  And I press "Update"
	  When I go to the issues page
	  Then I should see "Monkey Barfights"
	  And I should see "Simian Knockouts"
	  And I should see "Apeness"
	
	Scenario: Admin deletes an issue
	  Given I am logged in as an admin user
	  Given an issue named "IssueName"
	  When I go to the issues page
	  Then I should see "IssueName"
	  When I follow "IssueName"
	  Then I should see "Destroy"
	  When I follow "Destroy"
	  And I go to the issues page
	  Then I should not see "IssueName"
	
	
	# In order to keep a regular, relevant set of issues
	# As a contributor user
	# I should not be able to manage issues
	
  Scenario: Contributor visits issue page (no edit or destroy links)
		Given an issue named "Bat Politics"
		Given I am logged in as a contributor user
		When I go to the issues page
		Then I should see "Bat Politics"
		When I follow "Bat Politics"
		Then I should not see "Destroy"
		And I should not see "Edit"
		
		When I try to get '/issues/1/edit'
		Then it should tell me I am not authorized
		
  Scenario: HaxX0r does delete :destroy, :id => 1
		Given an issue named "Bat Politics"
		Given I am logged in as a contributor user
		When I send a packet with "delete '/issues/1'"
		Then it should tell me I am not authorized
		
	
		
	
		

Feature:  Browse Companies

	In order to find information on companies
	As a user
	I want to be able to get a list of companies and their scores
	
	Scenario: I request the companies page
		Given a company with name "Company_A"
		And a company with name "Company_B"
		When I go to the companies page
		Then I should see "Company_A" and "Company_B"
		
	Scenario: I click to view a company
		Given a company with name "Company_A" and description "Company_A's description" 
		When I go to the companies page
		And I follow "Company_A"
		Then I should see "Company_A"
		And I should see "Company_A's description"
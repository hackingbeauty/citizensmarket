Feature:  Admin Manage Companies

	In order to keep content up-to-date and growing
	As an admin user
	I want to administer companies and other details
	
	
	Scenario: Admins can add companies
		Given I am logged in as an admin user
		When I go to the homepage
		Then I should see "Add a Company"
	
	Scenario: Admin requests company form, fills it out, and submits it
		Given I am logged in as an admin user
		When I go to the new_company page
		#Then save_and_open_page
		When I fill in the following:
			| Name				| Brand New Company	|
			| Description 		| description		|
		And I press "Add"
		Then I should see "success"
		And I should see "Brand New Company"
		When I follow "Brand New Company"
		Then I should see "description"
		
	
	Scenario: Admin deletes a company
		Given I am logged in as an admin user
		Given a company with name "CompanyName"
		When I go to the companies page
		Then I should see "CompanyName"
		When I follow "CompanyName"
		Then I should see "Destroy"
		When I follow "Destroy"
		Then I should see "Company destroyed."
		When I go to the companies page
		Then I should not see "CompanyName"
	
	@focus	
	Scenario: Admin edits a company and saves it
		Given I am logged in as an admin user
		Given a company with name "British Petroleum" and description "An oil company"
		When I go to the edit company page for "British Petroleum"
		When I fill in the following:
			| Name				| British Petroleum	|
			| Description		| An energy company |
		When I press "Save"
		Then I should see "Company saved"
		And I should see "British Petroleum"
		And I should see "An energy company"
			
		
		
		
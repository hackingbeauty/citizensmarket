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
		Given a company named "CompanyName"
		When I go to the companies page
		Then I should see "CompanyName"
		When I follow "CompanyName"
		Then I should see "Destroy"
		When I follow "Destroy"
		Then I should see "Company destroyed."
		When I go to the companies page
		Then I should not see "CompanyName"
	
	Scenario: Admin edits a company and saves it
		
		Given I am logged in as an admin user
		Given a company
		# with name "British Petroleum" and description "An oil company"
		When I go to the company page
		Then I should see "Edit"
		
		When I follow "Edit"
		Then I should see a form
		#When I go to the edit company page# for "British Petroleum"
		
		When I fill in the following:
			| Name				| British Petroleum	|
			| Description		| An energy company |
		And I press "Save"
		
		Then I should see "Company saved"
		And I should see "British Petroleum"
		And I should see "An energy company"
			
  @focus
	Scenario: Contributor visits page (no edit or destroy links)
		#As an owner
		#I don't want contributors to be able to edit or destroy companies
		Given a company
		Given I am logged in as a contributor user
		When I go to the company page
		Then I should not see "Destroy"
		And I should not see "Edit"
		
		When I try to get '/companies/1/edit'
		Then it should tell me I am not authorized
		
		When I send a packet with "delete '/companies/1'"
		Then it should tell me I am not authorized
		
		
	
  Scenario: HaxX0r does delete :destroy, :id => 1
		Given a company
		Given I am logged in as a contributor user
		When I send a packet with "delete '/companies/1'"
		Then it should tell me I am not authorized
		
	
		
	
		
		
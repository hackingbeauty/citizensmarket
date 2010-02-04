Feature: User Profiles

  In order to establish an identity under which my reviews are written
  As any user
  I want to create and edit my profile
  
  
  
  Scenario:  User uploads a profile photo then views it on their profile
    Given I am logged in as a contributor user
		
		When I go to the my profile page
		Then I should see "Edit Profile"
		
		When I follow "Edit Profile"
		Then I should see a form
		
	  When I attach the file at "RAILS_ROOT/spec/test_images/duck.jpg" to "Profile Picture"
	  And I press "Save Profile"
	  Then I should see "success"
	  
	  When I go to the my profile page
	  Then I should see an image with src "duck.jpg"
	  And I should not see "Duck" 
	      # which is the alt text
	  
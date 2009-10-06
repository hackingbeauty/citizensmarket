module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when "Add a Company"
      new_company_path
    when /the homepage/
      '/'
    when /the (.*?(?= page)) page/
      eval("#{$1}_path")
    
    when /the new ([^\s]*) page/
      eval("new_#{$1}_path")  
      # ugly, I know.  
      #But I want to use RoutingSystem.route_named("new_company_path")
      # - why can't I figure out how to do this?
    
    
    
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)

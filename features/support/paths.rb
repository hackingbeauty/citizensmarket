module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

      when /the home\s?page/
        '/'
      when /the company page/
        company_path(@company)

      when /the edit company page for "(.*)"/
        edit_company_path(Company.find(:first, :conditions => ["name = ?", $1]))

      when "Add a Company"
        new_company_path

      when /the homepage/
        '/'

      when /the (.*?(?= page)) page/
        eval("#{$1.gsub(' ', '_')}_path")

      when /the new ([^\s]*) page/
        eval("new_#{$1}_path")

        # Add more mappings here.
        # Here is an example that pulls values out of the Regexp:
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

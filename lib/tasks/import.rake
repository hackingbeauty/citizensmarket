namespace :import do

  ## to use this:  place xml dump file at RAILS_ROOT/lib/importable.xml
  ## I know this is ugly, but I don't know how to pass a filepath argument to rake

  def map_oldtablenames_to_internal_classes
    [
      ['categories', 'IssueCategory'],
      ['company', 'Company'],
      ['issue', 'Issue'],
      ['peer_rating', 'PeerRating'],
      ['review', 'Review'],
      ['user', 'User'],
      ['user_cat', 'UserIssue']
    ]
  end 

  def old_to_new_ui_weight(n)
    n = n.to_i
    # if there is a discrepancy between the old and new weighting range
    # at time of writing this function, domain(old) = [0,10] while domain(new) = [0,5]
    (n.to_f / 2.to_f).floor
  end
  
  desc "converts xml into a more db-like schema (temporary, helps maintain associations)"
  task :create_internal_db do
    file = File.open("#{RAILS_ROOT}/lib/importable.xml", 'r')
    xml = REXML::Document.new(file)
    @internal_db = REXML::Document.new
    @internal_db.add_element('root')
    for oldname, newname in map_oldtablenames_to_internal_classes

      @internal_db.root.add_element(newname)


      # loop:  once for each element while removing element from xml doc
      while e = xml.root.delete_element(oldname)
        # create new xml from old, in proper place.    At root.newname.create_with_old_id
        new_element = REXML::Element.new(newname)
        e.each_element do |el|
          new_element.add_attribute('old_'+el.name, el.text)
        end
        new_element.add_attribute('import_status', 'notyet')
        new_element.add_attribute('import_brands_statsu', 'notyet') if newname == 'Company'
        @internal_db.root.elements[newname].add_element(new_element)
      end
    end
  end

  desc "imports all Users"
  task :transfer_users => [:create_internal_db, :environment] do

    attempted_count = 0
    saved_count = 0
    unsaved_count = 0
    preexisting_count = 0
    
    while user_xml = @internal_db.root.elements["User/User[@import_status='notyet']"]
      attempted_count += 1
      username = user_xml.attributes['old_u_name']
      existing = User.find(:first, :conditions => ['login = ?', username])
      if existing.class == User
        user_xml.add_attribute('new_id', existing.id.to_s)
        preexisting_count += 1
      else
      
        new_user_hash = {
          "name" => user_xml.attributes['old_fname'].to_s+' '+user_xml.attributes['old_lname'].to_s,
          "login" => user_xml.attributes['old_u_name'],
          "email" => user_xml.attributes['old_email'],
          "password" => user_xml.attributes['old_u_pword'],
          "password_confirmation" => user_xml.attributes['old_u_pword'],
        }
        new_user = User.new(new_user_hash)
        
        if new_user.save
          saved_count += 1
          user_xml.add_attribute('new_id', new_user.id.to_s)
        else
          unsaved_count += 1
        end
      end
        # don't grab this one again
        user_xml.add_attribute('import_status', 'complete')	
    end

    puts "Attempted to import #{attempted_count} Users from xml.  #{preexisting_count} were pre-existing, #{unsaved_count} could not be saved, #{saved_count} successfully transfered."
  end

  desc "imports all Companies"
  task :transfer_companies => [:environment, :create_internal_db] do

    attempted_count = 0
    saved_count = 0
    unsaved_count = 0
    preexisting_count = 0

    while x = @internal_db.root.elements["Company/Company[@import_status='notyet']"]
      attempted_count += 1
      existing = Company.find(:first, :conditions => ["name = ?", x.attributes['old_co_name']]) # this needs to be made case-insensitive
      if existing.class == Company
        x.add_attribute('new_id', existing.id.to_s)
        x.add_attribute('import_status', 'existing')
        preexisting_count += 1
      else
        new_company_hash = {
          "name" => x.attributes['old_co_name'],
          "description" => x.attributes['old_comments'],
        }
        new_company = Company.new(new_company_hash)

        if new_company.save
          saved_count += 1
          x.add_attribute('new_id', new_company.id.to_s)
        else
          unsaved_count += 1
        end

        x.add_attribute('import_status', 'complete')
      end
      x.add_attribute('import_status_brands', 'notyet')
    end
    puts "Attempted to import #{attempted_count} Companies from xml.  #{preexisting_count} were pre-existing, #{unsaved_count} could not be saved, #{saved_count} successfully transfered."
  end

  desc "imports all Issues"
  task :transfer_issues => [:environment, :create_internal_db] do
    attempted_count = 0
    saved_count = 0
    unsaved_count = 0
    preexisting_count = 0

    while x = @internal_db.root.elements["Issue/Issue[@import_status='notyet']"]
      attempted_count += 1
      existing = Issue.find(:first, :conditions => ["name = ?", x.attributes['old_top_name']]) # this needs to be made case-insensitive
      if existing.class == Issue
        x.add_attribute('new_id', existing.id.to_s)
        x.add_attribute('import_status', 'existing')
        preexisting_count += 1
      else
        old_category_id = x.attributes['old_cat_id']
        category_xml = @internal_db.root.elements["IssueCategory/IssueCategory[@old_cat_id='#{old_category_id}']"]
        new_category_name = nil
        unless category_xml.nil?
          new_category_name = category_xml.attributes['old_cat_name']
        end
        new_issue_hash = {
          "name" => x.attributes['old_cat_name'],
          "description" => x.attributes['old_desc'],
          "category" => new_category_name
        }
        new_issue = Issue.new(new_issue_hash)

        if new_issue.save
          saved_count += 1
          x.add_attribute('new_id', new_issue.id.to_s)
        else
          unsaved_count += 1
        end

        x.add_attribute('import_status', 'complete')
      end
    end
    puts "Attempted to import #{attempted_count} Issues from xml.  #{preexisting_count} were pre-existing, #{unsaved_count} could not be saved, #{saved_count} successfully transfered."
  end

  desc "imports all Reviews"
  task :transfer_reviews => [:transfer_companies, :transfer_users, :environment, :create_internal_db] do
    puts 'reviews are currently set to "published" status on import'
    attempted_count = 0
    saved_count = 0
    unsaved_count = 0
    preexisting_count = 0

    while x = @internal_db.root.elements["Review/Review[@import_status='notyet']"]
      attempted_count += 1
      existing = Review.find(:first, :conditions => ["body = ?", x.attributes['old_r_comment']]) # this needs to be made case-insensitive
      if existing.class == Review
        x.add_attribute('new_id', existing.id.to_s)
        x.add_attribute('import_status', 'existing')
        preexisting_count += 1
      else
        old_company_id = x.attributes['old_co_id']
        company_xml = @internal_db.root.elements["Company/Company[@old_co_id='#{old_company_id}']"]
        if company_xml.nil?
          unsaved_count += 1
          x.add_attribute('import_status', 'complete')
          next
        end
        old_user_name = x.attributes['old_uname']
        user_xml = @internal_db.root.elements["User/User[@old_u_name='#{old_user_name}']"]
        if user_xml.nil?
          unsaved_count += 1
          x.add_attribute('import_status', 'complete')
          next
        end
        
        new_company_id = company_xml.attributes['new_id']
        new_user_id = user_xml.attributes['new_id']
        new_review_hash = {
          "company_id" => new_company_id,
          "user_id" => new_user_id,
          "body" => x.attributes['old_r_comment'],
          "status" => "published",
        }
        new_review = Review.new(new_review_hash)

        if new_review.save
          saved_count += 1
          x.add_attribute('new_id', new_review.id.to_s)
        else
          unsaved_count += 1
        end

        x.add_attribute('import_status', 'complete')
        
      end
      x.add_attribute('import_status_review_issue', 'notyet')
    end
    puts "Attempted to import #{attempted_count} Reviews from xml.  #{preexisting_count} were pre-existing, #{unsaved_count} could not be saved, #{saved_count} successfully transfered."
  end

  desc "imports all ReviewIssues"
  task :transfer_review_issues => [:transfer_reviews, :transfer_issues, :environment, :create_internal_db] do
    attempted_count = 0
    saved_count = 0
    unsaved_count = 0
    preexisting_count = 0
    while x = @internal_db.root.elements["Review/Review[@import_status_review_issue='notyet']"]
      attempted_count += 1
      old_issue_id = x.attributes['old_top_id']
      issue_xml = @internal_db.root.elements["Issue/Issue[@old_top_id='#{old_issue_id}']"]
      if issue_xml.nil?
        unsaved_count += 1
        x.add_attribute('import_status_review_issue', 'complete')
        next
      end

      existing = ReviewIssue.find(:first, :conditions => ["review_id = ? and issue_id = ?", x.attributes['new_id'], issue_xml.attributes['new_id']])
      if existing.class == ReviewIssue
        x.add_attribute('new_review_issue_id', existing.id.to_s)
        x.add_attribute('import_status_review_issue', 'existing')
        preexisting_count += 1
      else
        new_review_issue_hash = {
          "review_id" => x.attributes['new_id'],
          "issue_id" => issue_xml.attributes['new_id'],
          "rating" => x.attributes['old_r_score'],
        }
        new_review_issue = ReviewIssue.new(new_review_issue_hash)

        if new_review_issue.save
          saved_count += 1
          x.add_attribute('new_review_issue_id', new_review_issue.id.to_s)
        else
          unsaved_count += 1
        end

        x.add_attribute('import_status_review_issue', 'complete')
      end
    end
    puts "Attempted to import #{attempted_count} ReviewIssues (aka Ratings) from xml.  #{preexisting_count} were pre-existing, #{unsaved_count} could not be saved, #{saved_count} successfully transfered."
    
  end

  desc "imports all PeerRatings"
  task :transfer_peer_ratings => [:transfer_reviews, :transfer_users, :environment, :create_internal_db] do
    puts "note PeerRatings are not imported because the previous database didn't track user_id for peer_ratings."
  end

  desc "imports all UserIssues"
  task :transfer_user_issues => [:transfer_users, :transfer_issues, :environment, :create_internal_db] do
    attempted_count = 0
    saved_count = 0
    unsaved_count = 0
    preexisting_count = 0
    
    while x = @internal_db.root.elements["UserIssue/UserIssue[@import_status='notyet']"]
      attempted_count += 1
      old_user_id = x.attributes['old_u_id']
      old_issue_id = x.attributes['old_top_id']
      user_xml = @internal_db.root.elements["User/User[@old_u_id='#{old_user_id}']"]
      if user_xml.nil?
        unsaved_count += 1
        x.add_attribute('import_status', 'complete')
        next
      end
      issue_xml = @internal_db.root.elements["Issue/Issue[@old_top_id='#{old_issue_id}']"]
      if issue_xml.nil?
        unsaved_count += 1
        x.add_attribute('import_status', 'complete')
        next
      end
      existing = UserIssue.find(:first, :conditions => ["user_id = ? and issue_id = ?", user_xml.attributes['new_id'], issue_xml.attributes['new_id']]) 
      if existing.class == UserIssue
        x.add_attribute('new_id', existing.id.to_s)
        x.add_attribute('import_status', 'existing')
        preexisting_count += 1
      else
        new_ui_hash = {
          "issue_id" => issue_xml.attributes['new_id'],
          "user_id" => user_xml.attributes['new_id'],
          "weight" => old_to_new_ui_weight(x.attributes['old_importance']),
        }
        new_ui = UserIssue.new(new_ui_hash)
        
        if new_ui.save
          saved_count += 1
          x.add_attribute('new_id', new_ui.id.to_s)
        else
          unsaved_count += 1
        end
        
        x.add_attribute('import_status', 'complete')        
      end
    end
    puts "Attempted to import #{attempted_count} UserIssues from xml.  #{preexisting_count} were pre-existing, #{unsaved_count} could not be saved, #{saved_count} successfully transfered."
  end

  desc "imports all Brands"
  task :transfer_brands => [:transfer_companies, :create_internal_db, :environment] do
    puts "note all imported Brands will have description = nil, as this isn't stored in the old db"
    attempted_count = 0
    saved_count = 0
    unsaved_count = 0
    preexisting_count = 0
    while x = @internal_db.root.elements["Company/Company[@import_status_brands='notyet']"]
      
      for name in x.attributes['old_brands'].split(', ')
        attempted_count += 1
        existing = Brand.find(:first, :conditions => ["name = ?", name])
        if existing.class == Brand
          preexisting_count += 1
        else
          new_brand_hash = {
            "company_id" => x.attributes['new_id'],
            "name" => name,
            "description" => nil
          }
          new_brand = Brand.new(new_brand_hash)
          if new_brand.save
            saved_count += 1
          else
            unsaved_count += 1
          end
        
        end
        
      end
      x.add_attribute('import_status_brands', 'complete')
    end
    puts "Attempted to import #{attempted_count} Brands from xml.  #{preexisting_count} were pre-existing, #{unsaved_count} could not be saved, #{saved_count} successfully transfered."    
  end

  desc "imports everything from the old db"
  task :transfer_all => [:transfer_user_issues, :transfer_reviews, :transfer_review_issues, :transfer_peer_ratings, :transfer_users, :transfer_issues, :transfer_companies, :transfer_brands, :create_internal_db, :environment] do
    puts "Transferred everything.  Enjoy your new content!"
  end

end
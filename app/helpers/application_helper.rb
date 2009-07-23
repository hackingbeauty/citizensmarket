# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Return a link for use in layout navigation.
  def nav_link(text, controller, action="index")
    if params[:action] == action
      html = "<li class='active'><span>" + link_to(text,:controller=> controller, :action=>action) + "</span></li>"
    else
      html = "<li><span>" + link_to(text,:controller=> controller, :action=>action) + "</span></li>"
    end
  end
  
  def categorized_issues_hash
    output = {}
    for issue_category in Issue.find(:all).map{|x| x.category}.uniq
      output[issue_category] = {}
      issues.select{|x| x.category == issue_category}.map{|x| output[issue_category][x.id] = x.name}
    end
    output
  end
  
  # Return true if some user is logged in, false otherwise.
  def admin_logged_in?
    not session[:admin_id].nil?
  end
  
  def render_tabs(tabs)
    tabs.inject("") do |tab_html, tab|
      tab[:on] ? tab_state = 'on' : tab_state = 'off'
      content_div = tab[:tab] || tab[:label].downcase.gsub(" ","_")
      link_url = tab[:link]
      tab_html += "<div class='tabimg_left_#{tab_state}'>&nbsp;</div>"
      tab_html += "<div class='tablink #{tab_state}' tab='#{content_div}'>#{link_to tab[:label], link_url}</div>"
      tab_html += "<div class='tabimg_right_#{tab_state}'>&nbsp;</div>"
    end
  end

  def favicon(domain)
    # TODO: cache
    "http://www.google.com/s2/favicons?domain=#{domain}"
  end

  def fixed_star_rating(rating, opts = {})
    dom_id = opts[:dom_id] || ""

    (1..10).inject("") do |html, i|
      if rating == i
        html += "<input name='star_#{dom_id}' type='radio' class='star-rating {split:2}' disabled='disabled' checked='checked'/>\n"
      else
        html += "<input name='star_#{dom_id}' type='radio' class='star-rating {split:2}' disabled='disabled'/>\n"
      end
    end
    
  end
  
  # Render stars for each company issue score
  def issue_score_star_rating(score)
    # The score is a number between 0.0 and 10.0
    # Return the number of stars to be drawn
    html = Array.new
    stars = score.to_f.to_stars - 1
    half_star = (stars != stars.to_i) ? true : false
    stars.to_i.times do |i|
      html << "<input name='star_rating' type='radio' class='star-rating star_on' disabled='disabled' />"
    end
    if half_star
      html << "<input name='star_rating' type='radio' class='star-rating star_on' disabled='disabled' checked='checked'/>" if stars > 0
      html << "<input name='star_rating' type='radio' class='star-rating star_on {split:2}' disabled='disabled' checked='checked'/>"
    else
      html << "<input name='star_rating' type='radio' class='star-rating star_on' disabled='disabled' checked='checked'/>"
    end
    return html.to_s
  end
  # Truncate the text at a specific word count.
  def snippet(text, wordcount)
      # TODO: This could be better written to normalize based on word size
    text.split[0..(wordcount-1)].join(" ") +(text.split.size > wordcount ? "..." : "")
  end

  # Temporary method to return a random hash for existing gravatar images
  def gravatar_hash
    hashes = ['767fc9c115a1b989744c755db47feb60',
              '5915fd742d0c26f6a584f9d21f991b9c',
              'b0b357b291ac72bc7da81b4d74430fe6',
              'a558f2098da8edf67d9a673739d18aff',
              '86debe7ed7ece0f968097a768dcbd5cb',
              '88e6c74e20866a91285dadb3347b2f01',
              '47a39c211cc16924d9fc6ad6249fb260',
              '987da1e668e6eb5cde64b52a477764ec',
              '69cc6c0327eaf95a3d730992f898a0cf',
              '8379aabc84ecee06f48d8ca48e09eef4',
              'd212b7b6c54f0ccb2c848d23440b33ba',
              'f4510afa5a1ceb6ae7c058c25051aed9',
              '1a33e7a69df4f675fcd799edca088ac2',
              'cb16a513e9017648da8f9b8335ba882e',
              'f73048cc21035713618d5ffa690001f4',
              '8821184e40ef08b2b0631f9bb1b5cf58',
              'eecc887dff6e1e42103590c76f215d87']
    hashes[rand(hashes.size)]
  end

  def user_name
    "#{Faker::Name.first_name} #{('A'..'Z').to_a[rand(25)]}."
  end

  def location
    "#{Faker::Address.city}, #{Faker::Address.us_state_abbr}"
  end

end

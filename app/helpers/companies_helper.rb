module CompaniesHelper
  
  def brand_name_list(company, opts = {})
    total_brands = company.brand_names.size
    top_9_brands = company.brand_names[0..9].join(', ')
    if total_brands > 10 and opts[:truncate]
      top_9_brands + ", " + link_to("#{total_brands - 10} more brands...", '')
    else
      top_9_brands
    end
  end
  
  def random_score
    score = rand(100)
    color_class = case score
      when 0..20 : "color_one"
      when 21..40 : "color_two"
      when 41..60 : "color_three"
      when 61..80 : "color_four"
      when 81..100 : "color_five"
    end
    score = score / 10.0
    "<div class=\"score #{color_class} rounded\">#{score}</div>"
  end
  
end

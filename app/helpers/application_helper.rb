# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
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
  
end

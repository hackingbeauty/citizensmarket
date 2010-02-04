class IssuesController < ResourceController::Base

  layout 'application'

  filter_access_to :all

  def issue_picker
    render :partial => 'issue_picker', :locals => {:parent_div_id => params[:parent_div_id], :removable => true}
  end

end

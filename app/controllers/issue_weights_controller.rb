class IssueWeightsController < ApplicationController

  def update
    UserIssue.update(params[:issue_weights].keys, params[:issue_weights].values.map{|v| {:weight => v.to_f}})
    @user = User.find(params[:user_id])
    render :partial => 'users/user_issues', :locals => {
      :user => @user, :user_issues => @user.user_issues,
      :container_div_id => params[:container_div_id], :errors_div_id => params[:errors_div_id]
    }
  end

end

class CompaniesController < ResourceController::Base
  
  def suggestions
    @results = Company.suggest(params[:q])
    render :text => @results.join("\n")
  end
  
  def lookup
    @company = Company.lookup_by_name(params[:q])
    render :json => @company, :except => [:created_at, :updated_at]
  end
  
  def lookup_logo
    render :text => Company.get_logo(params[:stock_symbol])
  end
  
end

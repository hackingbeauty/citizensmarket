class CompaniesController < ResourceController::Base

  def index
    @companies = Company.paginate :page => params[:page], :per_page => 2, :order => params[:sort] || "name asc"
  end
  
  def company_picker
    render :partial => 'company_picker'
  end
  
  def suggestions
    @results = CompanyLookup.suggest(params[:q])
    render :text => @results.join("\n")
  end
  
  def lookup
    @company = CompanyLookup.by_name(params[:q])
    render :json => @company, :except => [:created_at, :updated_at]
  end
  
  def lookup_logo
    render :text => CompanyLookup.get_logo(params[:stock_symbol])
  end

  def total_reviews
    num = Company.find(:all)
  end

end

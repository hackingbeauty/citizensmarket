class CompaniesController < ResourceController::Base
  
  #before_filter :login_required, :only => [:administer]
  filter_access_to :all

  def administer
    @companies = Company.find(:all)
  end
  
  def edit
    @company = Company.find(params[:id])
    if request.put?
      redirect_to :action => "administer"
    end
  end
  
  def destroy
      @company = Company.find(params[:id])
      if @company.destroy
        redirect_to :action => "administer"
      end
  end
  
  def company_picker
    render :partial => 'company_picker', :locals => {:object_name => params[:object_name], :object_company_id => params[:object_company_id]}
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

  def index
    @companies = Company.paginate   :per_page => 30, :page => params[:page], 
                                    :order => 'name'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end
  
  def show
    @company = Company.find(params[:id])
  end
  
  def create
    company = Company.new(params[:company])
    if company.save
      redirect_to :action => "administer"
    end
  end

end

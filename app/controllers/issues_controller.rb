class IssuesController < ApplicationController
  
  
  def issue_picker
    render :partial => 'issue_picker', :locals => {:parent_div_id => params[:parent_div_id], :removable => true}
  end
  
  
  # GET /issues
  # GET /issues.xml
  def index
    @issues = Issue.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.xml
  def show
    @issue = Issue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.xml
  def new
    @issue = Issue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    @issue = Issue.find(params[:id])
  end

  # POST /issues
  # POST /issues.xml
  def create
    @issue = Issue.new(params[:issue])

    respond_to do |format|
      if @issue.save
        flash[:notice] = 'Issue was successfully created.'
        format.html { redirect_to(@issue) }
        format.xml  { render :xml => @issue, :status => :created, :location => @issue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /issues/1
  # PUT /issues/1.xml
  def update
    @issue = Issue.find(params[:id])

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        flash[:notice] = 'Issue was successfully updated.'
        format.html { redirect_to(@issue) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.xml
  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to(issues_url) }
      format.xml  { head :ok }
    end
  end
end

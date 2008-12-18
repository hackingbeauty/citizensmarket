class PeerRatingsController < ApplicationController
  # GET /peer_ratings
  # GET /peer_ratings.xml
  def index
    @peer_ratings = PeerRating.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @peer_ratings }
    end
  end

  # GET /peer_ratings/1
  # GET /peer_ratings/1.xml
  def show
    @peer_rating = PeerRating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @peer_rating }
    end
  end

  # GET /peer_ratings/new
  # GET /peer_ratings/new.xml
  def new
    @peer_rating = PeerRating.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @peer_rating }
    end
  end

  # GET /peer_ratings/1/edit
  def edit
    @peer_rating = PeerRating.find(params[:id])
  end

  # POST /peer_ratings
  # POST /peer_ratings.xml
  def create
    @peer_rating = PeerRating.new(params[:peer_rating])

    respond_to do |format|
      if @peer_rating.save
        flash[:notice] = 'PeerRating was successfully created.'
        format.html { redirect_to(@peer_rating) }
        format.xml  { render :xml => @peer_rating, :status => :created, :location => @peer_rating }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @peer_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /peer_ratings/1
  # PUT /peer_ratings/1.xml
  def update
    @peer_rating = PeerRating.find(params[:id])

    respond_to do |format|
      if @peer_rating.update_attributes(params[:peer_rating])
        flash[:notice] = 'PeerRating was successfully updated.'
        format.html { redirect_to(@peer_rating) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @peer_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /peer_ratings/1
  # DELETE /peer_ratings/1.xml
  def destroy
    @peer_rating = PeerRating.find(params[:id])
    @peer_rating.destroy

    respond_to do |format|
      format.html { redirect_to(peer_ratings_url) }
      format.xml  { head :ok }
    end
  end
end

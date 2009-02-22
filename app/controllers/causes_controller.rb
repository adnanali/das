class CausesController < ApplicationController
  def index
    @causes = Cause.view("causes/all")
  end

  def show
    @cause = Cause.processed_find(params[:id])
    render :layout => 'cause'
  end

  def new
    @cause = Cause.new()
  end

  def create
    cause = Cause.new()

    # use the name as the unique id
    params[:cause]['_id'] = params[:cause][:name]


    respond_to do |format|
      if cause.save(params[:cause])
        format.html { redirect_to cause_url(cause) }
      end
    end
  end

  def edit
    @cause = Cause.find(params[:id])
  end

  def update
    @cause = Cause.find(params[:id])

    respond_to do |format|
      if @cause.update_attributes(params[:cause])
        RAILS_DEFAULT_LOGGER.debug "#{params[:cause].to_yaml}"
        format.html { redirect_to cause_url(@cause) }
      else
        format.html { render :action => :edit }
      end
    end
  end

  def destroy
  end

end
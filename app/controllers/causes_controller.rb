class CausesController < ApplicationController
  def index
    @causes = Cause.view(database_name, "causes/all")
  end

  def show
    @cause = Cause.find(database_name, params[:id])

    @intro = markdown(Liquid::Template.parse(@cause.intro).render('cause' => @cause.attributes))
    @find_form_message = markdown(Liquid::Template.parse(@cause.find_form_message).render('cause' => @cause.attributes))

    render :layout => 'cause'
  end

  def new
    @cause = Cause.new(database_name)
  end

  def create
    cause = Cause.new(database_name)

    # use the name as the unique id
    params[:cause]['_id'] = params[:cause][:name]

    respond_to do |format|
      if cause.save(params[:cause])
        format.html { redirect_to cause_url(cause) }
      end
    end
  end

  def edit
    @cause = Cause.find(database_name, params[:id])
  end

  def update
    @cause = Cause.find(database_name, params[:id])

    respond_to do |format|
      if @cause.save(params[:cause])
        format.html { redirect_to cause_url(@cause) }
        end
    end
  end

  def destroy
  end
end

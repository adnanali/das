class MpController < ApplicationController
  def by_postal_code
    @mp_info = Mp.get_mp_from_site(params[:postal_code])

    # if mp exists in db then don't insert, otherwise insert
    mp_id = "MP_#{@mp_info['riding']}"
    mp = Mp.find(mp_id)
    if (! mp)
      mp = Mp.new(@mp_info)
      mp._id = mp_id
      mp.save
    end
    @mp = mp

    #respond_to do |format|
    #  format.html {
        render :layout => false
    #  }
    #end
  end
end

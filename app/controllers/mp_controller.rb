require 'hpricot'
require 'open-uri'
class MpController < ApplicationController
  def by_postal_code
    @mp_info = Mp.get_mp_from_site(params[:id])

    # if mp exists in db then don't insert, otherwise insert
    mp_id = "MP_#{@mp_info['riding']}"
    mp = Mp.find(database_name, mp_id)
    if (! mp)
      mp = Mp.new(database_name, @mp_info)
      mp._id = mp_id
      mp.save
    end
    @mp = mp
  render :layout => false
  end
end

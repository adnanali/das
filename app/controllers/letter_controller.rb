class LetterController < ApplicationController
  def preview
    @letter = params[:letter]
    @cause = params[:cause]
    render :layout => false
  end

  def send_letter
    # let's use the riding name to get the mp info

    mp = Mp.find("MP_#{params[:riding]}")
    @letter = params[:letter]
    @letter = ActiveSupport::JSON.decode(@letter)
    @letter['mp_info'] = mp
    @letter['cause'] = params[:cause]

    @cause = Cause.processed_find(@letter['cause'])

    l = Letter.new(@letter)
    l.save

    # send this letter out here
    LetterMail::deliver_letter(@letter, params[:message])

    render :layout => false
  end
end

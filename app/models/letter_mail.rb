class LetterMail < ActionMailer::Base
  

  def letter(my_letter, message)
    subject    my_letter[:subject]
    recipients 'adnan.ali@gmail.com' # my_letter[:mp_info][:email]
    from       my_letter['user']['email']
    headers    "Reply-to" => my_letter['user']['email']
    sent_on    Time.now
    
    body       :message => message.gsub(/<[^>]*>/, "").split("\n").map { |line|
      line.strip
    }.join("\n")
  end

end

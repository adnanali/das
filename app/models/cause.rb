class Cause < BasicModel
  database_name :demand

  def self.processed_find(id)
    cause = find(id)

    # follow fields need to be liquidated and markdowned
    # intro
    # find_form_message
    # letter_note
    # after_send_message
    cause.intro = mark_liquid(cause.intro, {:cause => cause})
    cause.find_form_message = mark_liquid(cause.find_form_message, {:cause => cause})
    cause.letter_note = mark_liquid(cause.letter_note, {:cause => cause})
    cause.after_send_message = mark_liquid(cause.after_send_message, {:cause => cause})
    cause
  end


  private

  def self.markdown(text)
    Markdown.new(text).to_html
  end

  def self.mark_liquid(field, values={})
    markdown(Liquid::Template.parse(field).render(values))
  end
end

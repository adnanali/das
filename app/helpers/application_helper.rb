# Methods added to this helper will be available to all templates in the application.
require 'rdiscount'
module ApplicationHelper
  def to_markdown(text)
    Markdown.new(text).to_html
  end
end

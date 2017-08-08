module ApplicationHelper
  BLOG_NAME = 'ageage'
  BLOG_NAME.freeze
  
  def page_title
    title = BLOG_NAME
    title = "#{@page_title} | #{BLOG_NAME}" if @page_title
    title
  end

  def blog_name
    BLOG_NAME
  end
end

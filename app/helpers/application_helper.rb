module ApplicationHelper
  BLOG_NAME = 'アゲブログ'
  BLOG_NAME.freeze

  def page_title
    title = BLOG_NAME
    title = "#{@page_title} | #{BLOG_NAME}" if @page_title
    title
  end

  def blog_name
    BLOG_NAME
  end

  def parameter_tag_list
    if params[:tag_list].present?
      params[:tag_list]
    else
      []
    end
  end
end

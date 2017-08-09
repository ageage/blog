module MarkdownHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true);

    html = Redcarpet::Markdown.new(renderer,
                                   autolink: true,
                                   space_after_headers: true,
                                   no_intra_emphansis: true,
                                   fenced_code_blocks: true,
                                   tables: true,
                                   lax_html_block: true,
                                   strikethrough: true,
                                   superscript: true
    ).render(text)

    apply_syntax_highlight(html).html_safe
  end

  def apply_syntax_highlight(html)
    doc = Nokogiri::HTML html
    doc.search('pre').each do |pre|
      pre.replace(Pygments.highlight(
          pre.text.rstrip,
          lexer: get_lexer_or_else(pre.child)
      ))
    end
    doc.to_s
  end

  def get_lexer_or_else(element, default='text')
    if element.attribute('class')
      element.attribute('class').value
    else
      default
    end
  end
end

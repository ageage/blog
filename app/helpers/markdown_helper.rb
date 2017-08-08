module MarkdownHelper
  def markdown(text)

    options = {
        autolink: true,
        space_after_headers:true,
        no_intra_emphansis: true,
        fenced_code_blocks: true,
        tables: true,
        hard_wrap: true,
        xhtml: true,
        lax_html_block: true,
        strikethrough: true
    }

    renderer = Redcarpet::Render::HTML.new();

    Redcarpet::Markdown.new(renderer, options).render(text).html_safe

  end
end

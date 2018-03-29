module MarkdownHelper
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'
  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def markdown(text)
    renderer = HTML.new(
        filter_html: true,
        hard_wrap:   true
    )

    html = Redcarpet::Markdown.new(
        renderer,
        autolink:            true,
        space_after_headers: true,
        no_intra_emphansis:  true,
        fenced_code_blocks:  true,
        tables:              true,
        lax_html_block:      true,
        strikethrough:       true,
        superscript:         true
    ).render(text)

    html.html_safe
  end
end

module AboutHelper
  def render_markdown(content)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    markdown.render(content).html_safe
  end
end

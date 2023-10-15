module AboutHelper
  def render_markdown(content)
    content.gsub!(/^# (.*?)$/, "## About the app:")
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    markdown.render(content).html_safe
  end
end

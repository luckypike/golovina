module ApplicationHelper
  def menu_index?
    %w(static).include?(controller_name) && %w(index).include?(action_name)
  end

  def lipsum_index
    'Что ни вечер, то прогулка по городу или посиделки на верандах, что ни выходной, то поход в музей или dfgf.'
  end

  def typekit_include_tag
    javascript_include_tag('//use.typekit.net/crp6yvg.js') +
    javascript_tag('try{Typekit.load({ async: true });}catch(e){}')
  end

  def markdown text
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      space_after_headers: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
end

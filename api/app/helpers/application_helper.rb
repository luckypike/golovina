# frozen_string_literal: true

module ApplicationHelper
  def appleid
    {
      client_id: Figaro.env.appleid_client_id!,
      redirect_uri: URI(Figaro.env.appleid_redirect_uri!)
    }
  end

  def locale_url_for(path, locale, options = {})
    host = (locale && I18n.default_locale != locale ? "#{locale}." : "") + Figaro.env.host

    send(path, options.merge(host: host))
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true, no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      space_after_headers: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
end

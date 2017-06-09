module ApplicationHelper

  def typekit_include_tag
    javascript_include_tag('//use.typekit.net/crp6yvg.js') +
    javascript_tag('try{Typekit.load({ async: true });}catch(e){}')
  end
end

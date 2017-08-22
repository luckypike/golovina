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
end

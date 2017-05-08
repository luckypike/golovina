module ProductsHelper
  def number_to_rub val
    number_with_precision(val, precision: (val.round == val) ? 0 : 2, separator: ',', delimiter: '&nbsp;'.html_safe) + ' ₽'
  end
end

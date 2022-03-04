# frozen_string_literal: true

json.variants do
  json.partial! 'variants/list', variants: @variants.sort_by { |v| [v.category.weight, v.weight] }
end

json.color @color, partial: 'colors/color', as: :color
json.partial! 'colors/values', color: @color

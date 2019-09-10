json.color do
  json.partial! @color
end

json.partial! 'values', color: @color

json.theme do
  json.partial! @theme
end

json.partial! 'values', theme: @theme

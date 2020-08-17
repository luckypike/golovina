json.object do
  if @kits.size > 0
    json.kits do
      json.partial! 'kits/list', kits: @kits
    end
  end

  if @variants.size > 0
    json.variants do
      json.partial! 'variants/list', variants: @variants
    end
  end
end

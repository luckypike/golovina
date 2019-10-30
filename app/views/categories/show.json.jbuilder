json.variants @variants do |variant|
  json.cache! variant, expires_in: 10.minutes do
    json.partial! 'variants/variant', variant: variant
  end
end

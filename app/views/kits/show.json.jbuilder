json.kit do
  json.partial! @kit
  json.title @kit.human_title

  json.variants @kit.variants do |variant|
    json.partial! variant

    json.availabilities do
      json.partial! 'variants/availabilities', availabilities:  variant.availabilities
    end
  end
end

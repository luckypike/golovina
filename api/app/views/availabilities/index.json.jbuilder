json.availabilities @availabilities do |availability|
  json.partial! availability

  # TODO: Temp
  # json.quantity availability.acts.sum(:quantity)

  json.stores Store.all do |store|
    json.partial! store

    json.quantity availability.acts.where(store: store).sum(:quantity)
  end

  # json.acts availability.acts do |act|
  #   json.partial! act
  #
  #   json.store do
  #     json.partial! act.store
  #   end
  # end

  json.size do
    json.partial! availability.size
  end
end

json.variant do
  json.partial! @variant
end

json.sizes Size.all do |size|
  json.partial! size
end

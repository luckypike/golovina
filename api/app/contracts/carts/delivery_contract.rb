# frozen_string_literal: true

module Carts
  class DeliveryContract < ApplicationContract
    Deliveries = Dry::Types['strict.string'].enum(*Api::Order.deliveries.keys)
    DeliveryOptions = Dry::Types['strict.string'].enum(*Api::Order.delivery_options.keys)

    params do
      required(:delivery).filled(Deliveries)
      optional(:delivery_city_id).maybe(:integer)
      optional(:delivery_option).maybe(DeliveryOptions)

      optional(:zip).maybe(:string)
      optional(:country).maybe(:string)
      optional(:city).maybe(:string)
      optional(:street).maybe(:string)
      optional(:house).maybe(:string)
      optional(:appartment).maybe(:string)
    end

    rule(:delivery_city_id) do
      key.failure(:filled?) if value.blank? && values[:delivery] == 'russia'
    end

    rule(:delivery_option) do
      key.failure(:filled?) if value.blank? && values[:delivery] == 'russia'
    end

    rule(:zip) do
      key.failure(:filled?) if value.blank? && %w[russia international].include?(values[:delivery])
    end

    rule(:country) do
      key.failure(:filled?) if value.blank? && %w[international].include?(values[:delivery])
    end

    rule(:city) do
      key.failure(:filled?) if value.blank? && %w[international].include?(values[:delivery])
    end

    rule(:street) do
      key.failure(:filled?) if value.blank? && %w[russia international].include?(values[:delivery])
    end

    rule(:house) do
      key.failure(:filled?) if value.blank? && %w[russia international].include?(values[:delivery])
    end

    rule(:appartment) do
      key.failure(:filled?) if value.blank? && %w[russia international].include?(values[:delivery])
    end
  end
end

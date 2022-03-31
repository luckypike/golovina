# frozen_string_literal: true

json.array! @orders do |order| # rubocop:disable Metrics/BlockLength
  json.partial! order
  json.extract! order, :quantity, :updated_at, :amount_delivery
  json.amount order.payment_amount.presence || order.amount.presence || order.amount_calc

  if order.delivery_city
    json.delivery_city do
      json.partial! order.delivery_city
    end
  end

  json.promo_code order.promo_code, :id, :title if order.promo_code

  json.user do
    json.partial! order.user
  end

  json.items order.items do |item| # rubocop:disable Metrics/BlockLength
    json.partial! item
    json.preorder item.acts.any?(&:preorder?)

    act = item.acts.detect(&:paid?)
    json.store act.store, :id, :title if act

    json.variant do
      json.partial! item.variant
      json.available item.variant.available?

      json.title item.variant.title_last.squish

      json.images item.variant.images.active_and_ordered.each do |image|
        json.id image.id
        json.thumb image.thumb_url if image.file.attached?
      end

      if item.variant.category
        json.category do
          json.extract! item.variant.category, :id, :slug
        end
      end

      json.color do
        json.partial! item.variant.color
      end
    end

    if item.size
      json.size do
        json.partial! item.size
      end
    end
  end
end

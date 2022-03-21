# frozen_string_literal: true

module Refunds
  class CreateCmd < ApplicationCmd
    input :refund_params
    input :user
    output :refund

    def call
      params = validate_contract!(CreateContract, refund_params)

      self.refund = create_refund(params, user)
      notify(refund)
    end

    private

    def create_refund(params, user)
      Api::Refund.transaction do
        refund = Api::Refund.new(params.except(:order_item_ids))
        refund.user = user
        refund.state = :active
        validate_and_save(refund)
        validate_and_save_order_items(refund, params[:order_item_ids])
        refund
      end
    end

    def validate_and_save(refund)
      validate_entity!(refund)
      refund.save!
    end

    def validate_and_save_order_items(refund, order_item_ids)
      order_item_ids.each do |order_item_id|
        refund_order_item = Api::RefundOrderItem.new(refund: refund, order_item_id: order_item_id)
        validate_entity!(refund_order_item)
        refund_order_item.save!
      end
    end

    def notify(refund)
      RefundMailer.with(refund: refund).create.deliver_later
    end
  end
end

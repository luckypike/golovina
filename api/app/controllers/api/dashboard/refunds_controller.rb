# frozen_string_literal: true

module Api
  module Dashboard
    class RefundsController < ::Api::ApplicationController
      before_action :set_refund, only: %i[archive]
      before_action :authorize_refund

      def index
        @refunds = Api::Refund
          .includes(
            [
              :order, :user,
              {
                refund_order_items: { order_item: [:size, { variant: [:translations, { color: :translations }] }] }
              }
            ]
          )
          .order(created_at: :desc)
      end

      def archive
        @refund.state_archive!
      end

      private

      def set_refund
        @refund = Api::Refund.find(params[:id])
      end

      def authorize_refund
        authorize @refund || Refund
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module Dashboard
    class RefundsController < ::Api::ApplicationController
      before_action :set_refund

      def archive
        authorize @refund
        @refund.state_archive!
      end

      private

      def set_refund
        @refund = Api::Refund.find(params[:id])
      end
    end
  end
end

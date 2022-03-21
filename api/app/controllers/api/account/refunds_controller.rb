# frozen_string_literal: true

module Api
  module Account
    class RefundsController < Api::ApplicationController
      def create
        authorize Refund.new(user: current_user)
        @cmd = Refunds::CreateCmd.call(user: current_user, refund_params: params)
      end

      def index
        authorize Refund
        @cmd = Refunds::IndexCmd.call(user: current_user)
      end
    end
  end
end

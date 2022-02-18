# frozen_string_literal: true

module Api
  class CartsController < Api::ApplicationController
    before_action :authorize_cart

    def show
      @cmd = Carts::ShowCmd.call(user: current_user)
    end

    def apply_promo_code
      Carts::PromoCodes::ApplyCmd.call(user: current_user, promo_code_params: params)
    end

    def delete_promo_code
      Carts::PromoCodes::DeleteCmd.call(user: current_user)
    end

    private

    def authorize_cart
      authorize %i[api cart]
    end
  end
end

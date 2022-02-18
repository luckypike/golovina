# frozen_string_literal: true

module Api
  class CartsController < Api::ApplicationController
    def show
      authorize :cart

      @cmd = Carts::ShowCmd.call(user: current_user)
    end
  end
end

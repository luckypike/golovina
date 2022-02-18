# frozen_string_literal: true

module Api
  class CartPolicy < Api::ApplicationPolicy
    def show?
      user
    end

    def apply_promo_code?
      show?
    end

    def delete_promo_code?
      apply_promo_code?
    end
  end
end

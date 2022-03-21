# frozen_string_literal: true

module Api
  class RefundPolicy < Api::ApplicationPolicy
    def index?
      user
    end

    def create?
      user && user.id == record.user_id
    end

    def archive?
      user&.editor?
    end
  end
end

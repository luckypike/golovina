# frozen_string_literal: true

module Api
  class RefundPolicy < Api::ApplicationPolicy
    def new?
      user
    end

    def index?
      user&.editor?
    end

    def create?
      user && user.id == record.user_id
    end

    def archive?
      user&.editor?
    end
  end
end

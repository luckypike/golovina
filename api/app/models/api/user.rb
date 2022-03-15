# frozen_string_literal: true

module Api
  class User < ApplicationRecord
    enum state: { guest: 0, active: 1 }, _prefix: true

    has_many :identities, dependent: :destroy
    has_many :orders, dependent: :restrict_with_exception

    validates :email, presence: true, uniqueness: true
    validates :phone, uniqueness: true, allow_blank: true
    validates :state, presence: true

    def full_name
      [name, sname].join(" ")
    end
  end
end

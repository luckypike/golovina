# frozen_string_literal: true

module Sessions
  class SendCodeBySmsCmd < ApplicationCmd
    input :code_params

    def call
      params = validate_contract!(SendCodeBySmsContract, code_params)
      user = Api::User.find_by!(phone: params[:phone])
      user.update(phone_code: phone_code.to_s) if user.phone_code.blank?
      Sessions::SendCodeJob.perform_later(user: user)
    end

    private

    def phone_code
      Rails.env.production? ? rand(1000..9999) : 1111
    end
  end
end

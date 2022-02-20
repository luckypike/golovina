# frozen_string_literal: true

module Sessions
  class SignInWithAppleIdCmd < ApplicationCmd
    input :current_user
    input :token_params
    input :referer
    input :user_params
    output :user

    def call
      params = validate_contract!(
        SignInWithAppleIdContract, { token: token_params, referer: referer, user: user_params }.compact
      )
      params[:user] ||= { name: { firstName: nil, lastName: nil } }

      validate_referer!(params[:token], params[:referer])
      create_and_sign_in(params)
    end

    private

    def create_and_sign_in(params)
      identity = find_or_build_identity(params[:token])
      user = find_or_build_user(identity, params[:token])
      attach_params_to_user(user, params[:user])
      validate_and_save_user(user)
      move_cart(user)
      self.user = user
    end

    def validate_referer!(token_params, referer)
      fail!(http_status_code: :unprocessable_entity) unless referer.starts_with?(token_params[:iss])
    end

    def find_or_build_identity(token_params)
      Api::Identity.where(provider: :apple, uid: token_params[:sub]).first_or_initialize
    end

    def find_or_build_user(identity, token_params)
      if identity.new_record?
        user = Api::User.where(email: token_params[:email]).first_or_initialize
        user.identities << identity
        user
      else
        identity.user
      end
    end

    def attach_params_to_user(user, user_params)
      user.name ||= user_params[:name][:firstName]
      user.sname ||= user_params[:name][:lastName]
      user.state = :active
    end

    def validate_and_save_user(user)
      validate_entity!(user)
      user.save!
    end

    def move_cart(user)
      return unless current_user&.guest?

      user.orders.state_cart.first&.destroy
      current_user.orders.state_cart.first&.update(user_id: user.id)
    end
  end
end

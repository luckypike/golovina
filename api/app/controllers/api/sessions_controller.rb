# frozen_string_literal: true

module Api
  class SessionsController < Api::ApplicationController
    before_action :authorize_session

    def show; end

    def apple
      @cmd = Sessions::SignInWithAppleIdCmd.call(
        current_user: current_user,
        token_params: decode_token_params,
        referer: request.referer,
        user_params: parse_user_params
      )

      sign_in_with_jwt(::User.find(@cmd.user.id))

      # TODO: Rewrite it
      redirect_uri = params[:return_uri].presence || "/"
      redirect_uri = "/cart#checkout" if redirect_uri == "/cart"
      redirect_to redirect_uri
    end

    def code
      Sessions::SendCodeBySmsCmd.call(code_params: params)
    end

    private

    def sign_in_with_jwt(user)
      sign_in(user)
      cookies[:_golovina_jwt] = {
        value: Sessions::SetJwtSessionCmd.call(user: user).token,
        expires: 1.year, httponly: true
      }
    end

    def parse_user_params
      Oj.load(params[:user], symbol_keys: true, nilnil: true)
    end

    def decode_token_params
      JWT.decode(params[:id_token], nil, false)[0]
    rescue JWT::DecodeError
      nil
    end

    def authorize_session
      authorize %i[api session]
    end
  end
end

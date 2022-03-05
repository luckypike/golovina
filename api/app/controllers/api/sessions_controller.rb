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

      sign_in(::User.find(@cmd.user.id))
      redirect_to params[:return_uri].presence || '/'
    end

    private

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

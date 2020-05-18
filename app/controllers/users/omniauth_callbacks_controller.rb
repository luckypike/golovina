module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_after_action :verify_authorized
    skip_before_action :verify_authenticity_token

    def apple
      auth = JWT.decode(params[:id_token], nil, false)[0]

      name = params[:user] ? JSON.parse(params[:user])['name'] : nil
      name ||= {
        firstName: nil,
        lastName: nil
      }

      identity = Identity.where(provider: :apple, uid: auth['sub']).first_or_initialize

      if identity.new_record?
        auth['email'] ||= "guest_#{Devise.friendly_token.first(10)}@golovina.store"
        user = User.where(email: auth['email']).first_or_initialize(name: name['firstName'], sname: name['lastName'], state: :common)
        user.identities << identity
        user.save!(validate: false)

      else
        identity.user.email = auth['email'] if identity.user.guest_email? && auth['email']
        identity.user.name ||= name['firstName'] if name['firstName']
        identity.user.sname ||= name['lastName'] if name['lastName']
        identity.user.save!(validate: false)
        user = identity.user
      end

      if current_user&.guest?
        # Cart.where(user: Current.user).update_all(user_id: user.id)
        # Wishlist.where(user: Current.user).update_all(user_id: user.id)
      end

      sign_in user
      redirect_to after_sign_in_path_for(user)
    end

    def failure
      redirect_to root_path
    end
  end
end

# frozen_string_literal: true

Rails.application.config.session_store :cookie_store, key: :_golovina_session, domain: :all, expire_after: 1.month

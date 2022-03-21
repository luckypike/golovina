# frozen_string_literal: true

module Instagram
  class UpdateCmd < ApplicationCmd
    def call
      # token = Token.find_by!(key: :instagram)
      # uri = URI("https://graph.instagram.com/me/media?fields=id,media_type,media_url,permalink&access_token=#{token.value}")
      # res = Net::HTTP.get_response(uri)

      # raise StandardError unless res.code == "200"

      # data = JSON.parse(res.body).with_indifferent_access[:data]
      # Rails.cache.write("instagram", data)
    end
  end
end

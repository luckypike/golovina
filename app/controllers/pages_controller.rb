class PagesController < ApplicationController
  before_action :authorize_page

  def index
    @slides = Slide.with_translations(I18n.available_locales)
      .where.not(image: nil).order(weight: :asc)
  end

  def instagram
    url = "https://graph.instagram.com/me/media?fields=id,media_type,media_url,permalink&access_token=#{Rails.application.credentials.dig(:instagram, :token)}"

    @posts = JSON.parse(Net::HTTP.get(URI(url)))

    respond_to :json
  end

  def robots
    respond_to :text
    expires_in 6.hours, public: true
  end

  # def contacts; end

  private

  def authorize_page
    authorize :page
  end
end

class PagesController < ApplicationController
  before_action :authorize_page

  def index
    @slides = Slide.with_translations(I18n.available_locales)
      .includes(:video_mp4_attachment)
      .where.not(image: nil).order(weight: :asc)

    set_meta_tags 'facebook-domain-verification': 'gq1zcts3t1t3zp0vuyh34su8tqowbk'
  end

  def instagram
    @posts = Rails.cache.read('instagram')

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

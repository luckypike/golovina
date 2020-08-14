class Kit < ApplicationRecord
  enum state: { undef: 0, active: 1, archived: 2 }

  default_scope { order(created_at: :desc) }
  scope :latest, -> { where(latest: true) }

  has_many :kitables, dependent: :destroy
  has_many :variants, through: :kitables

  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images

  has_one_attached :video
  has_one_attached :video_mp4
  has_one_attached :video_poster

  belongs_to :category, optional: true

  validates :state, presence: true

  after_save :update_category_variants_counter

  translates :title
  globalize_accessors locales: I18n.available_locales, attributes: %i[title]

  def human_title
    title.present? ? title : variants.map(&:title_last).to_sentence.downcase.upcase_first
  end

  def entity_created_at
    created_at
  end

  def photo
    images[0].photo.presence || nil
  end

  def update_category_variants_counter
    Category.find(category_id_before_last_save).update_variants_counter if category_id_before_last_save
    category.update_variants_counter
  end

  class << self
    def for_list
      with_translations(I18n.available_locales)
        .includes(
          :video_mp4_attachment,
          :images,
          {
          variants: [
            :images,
            :translations,
            :availabilities,
            color: :translations,
            product: %i[translations category]
          ]
        }
        )
    end
  end
end

class Availability < ApplicationRecord
  scope :active, -> { where.not(quantity: 0) }
  scope :inactive, -> { where(quantity: [0, nil]) }

  belongs_to :variant
  belongs_to :size
  has_many :acts, dependent: :restrict_with_error
  # belongs_to :store

  # after_save :check_variant

  validates :size, uniqueness: { scope: :variant_id }
  validates :quantity, presence: true

  after_initialize do
    self.quantity = quantity.to_i
  end

  before_destroy :destroy_manual_acts, prepend: true

  # def check_variant
  #   variant.check_state
  # end

  def active?
    quantity&.positive?
  end

  private

  def destroy_manual_acts
    return if active? || acts.size != acts.manual.size

    acts.destroy_all
  end
end

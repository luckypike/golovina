class Availability < ApplicationRecord
  scope :active, -> { where.not(quantity: 0) }
  scope :inactive, -> { where(quantity: [0, nil]) }

  belongs_to :variant
  belongs_to :size
  has_many :acts
  # belongs_to :store

  # after_save :check_variant

  validates :size, uniqueness: { scope: :variant_id }
  validates :quantity, presence: true

  after_initialize do
    self.quantity = quantity.to_i
  end


  # def check_variant
  #   variant.check_state
  # end

  def active?
    quantity&.positive?
  end
end

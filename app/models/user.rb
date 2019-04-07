class User < ApplicationRecord
  enum state: { guest: 0, common: 1 }

  has_many :wishlists
  has_many :carts
  has_many :orders

  has_one :discount

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :phone
  validates_presence_of :phone, :name

  validates :phone, length: { is: 11 }

  before_validation :clear_email, on: :update
  before_validation :clear_phone

  def remember_me
    true
  end

  def is_admin?
    self.id == 1
  end

  def is_editor?
    is_admin? || [2, 3].include?(id)
  end

  def tester?
    Rails.application.credentials.payment[:test_phones].include?(phone)
  end

  def clear_phone
    if self.phone.present?
      self.phone = User.prepare_phone(self.phone)
    end
  end

  def clear_email
    restore_attributes([:email]) if email.blank?
  end

  def get_discount
    self.discount.present? ? self.discount.size : 0
  end

  class << self
    def prepare_phone text
      text ||= ''
      text = text.sub('/^8/', '+7').gsub(/[\D]/, '')
      text.size == 11 && text[1] == '9' ? text : false
    end
  end
end

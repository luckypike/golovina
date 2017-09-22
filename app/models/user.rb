class User < ApplicationRecord
  has_many :wishlists
  has_many :carts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :phone
  validates_presence_of :phone, :name

  def remember_me
    true
  end

  def is_guest?
    self.email.start_with?('guest_') && self.email.end_with?('@mint-store.ru') && self.phone.blank?
  end

  def is_admin?
    self.id == 1
  end

  def is_editor?
    is_admin? || [2, 3].include?(id)
  end
end

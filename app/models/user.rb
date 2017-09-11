class User < ApplicationRecord
  has_many :wishlists
  has_many :carts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def remember_me
    true
  end

  def is_admin?
    self.id == 1
  end

  def is_editor?
    is_admin? || [2].include?(id)
  end
end

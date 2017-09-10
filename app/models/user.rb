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
    self.id == 1 || self.id == 2
  end

  def is_editor?
    is_admin?
  end
end

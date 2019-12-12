class User < ApplicationRecord
  enum state: { guest: 0, common: 1 }

  has_many :wishlists, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :nullify
  has_many :refunds
  has_many :notifications, dependent: :destroy
  has_many :identities, dependent: :destroy

  has_one :discount

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :email, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # before_validation :clear_email, on: :update
  # before_validation :clear_phone

  def remember_me
    true
  end

  def is_admin?
    self.id == 1
  end

  def is_editor?
    is_admin? || editor
  end

  def tester?
    Rails.application.credentials.payment[:test_phones].include?(phone)
  end

  def activate(email, type: :notify)
    password = Devise.friendly_token.first(8)
    self.email = email
    self.password = password
    self.state = :common
    save!(validate: false)
    # RegisterMailer.register_mailer(password, self).deliver_now
    RegisterMailer.send("#{type}_mailer", password, self).deliver_now
  end

  # def clear_phone
  #   if self.phone.present?
  #     self.phone = User.prepare_phone(self.phone)
  #   end
  # end

  def clear_email
    restore_attributes([:email]) if email.blank?
  end

  def get_discount
    self.discount.present? ? self.discount.size : 0
  end

  def s_name
    sname
  end

  def guest_email?
    email.match(/guest_.*?@golovina\.store/i)
  end

  class << self
    def destroy_old_user(old_user)
      if old_user.guest?
        old_user.destroy
      elsif old_user.orders.where(state: %i[paid archived]).empty?
        # old_user.orders.destroy_all
        old_user.destroy
      end
    end
  end
end

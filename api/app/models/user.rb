class User < ApplicationRecord
  attr_accessor :skip_validation

  enum state: { guest: 0, common: 1 } do
    event :activate do
      after do
        pp 'ACTIVATE'
      end

      transition guest: :common
    end
  end

  has_many :wishlists, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :refunds, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :user_addresses, dependent: :destroy
  alias_attribute :addresses, :user_addresses

  # has_one :discount

  validates :name, :sname, :phone, presence: true, if: -> { common? && !skip_validation }

  validates :email,
    presence: true, uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  def remember_me
    true
  end

  def admin?
    id == 1
  end

  def editor?
    admin? || editor
  end

  # def activate(email, type: :notify)
  #   password = Devise.friendly_token.first(8)
  #   self.email = email
  #   self.password = password
  #   self.state = :common
  #   save!(validate: false)
  #   # RegisterMailer.register_mailer(password, self).deliver_now
  #   RegisterMailer.send("#{type}_mailer", password, self).deliver_now
  # end

  def cart
    orders.for_amount.cart.first_or_create
  end

  def guest_email?
    email.match(/guest_.*?@golovina\.store/i)
  end

  def reset_password(new_password, new_password_confirmation)
    if new_password.present?
      self.skip_validation = true
      self.password = new_password
      self.password_confirmation = new_password_confirmation
      save
    else
      errors.add(:password, :blank)
      false
    end
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

    def guest_email
      "guest_#{Devise.friendly_token.first(10)}@golovinamari.com"
    end
  end

  # Rewrite until protected

  def is_admin? # rubocop:disable Naming/PredicateName
    admin?
  end

  def is_editor? # rubocop:disable Naming/PredicateName
    editor?
  end

  def s_name
    sname
  end

  def title
    [name, sname].join(' ').squish
  end

  protected

  def password_required?
    guest? ? false : super
  end
end

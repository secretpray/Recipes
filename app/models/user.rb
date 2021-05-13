class User < ApplicationRecord
  include UserOath

  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  has_one_attached :avatar

  validates :email, presence: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  # validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :username, presence: true
  # validate :uniq_email
  # validate :uniq_username

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :github, :google_oauth2]

  enum role: %i(user moderator admin)

  acts_as_voter

  scope :by_recipes_count, -> { User.left_joins(:recipes).group(:id).order('COUNT(recipes) DESC') } #.pluck(:id, :email) max -> first
  
  attr_writer :login

  def login
    @login || username || email
  end

  def uniq_username
    binding.pry
    if provider.empty?
      if User.where(email: username).exists?
        errors.add(:username, :invalid)
      end
    end
  end

  # ??? ref
  def uniq_email
    binding.pry
    if provider.empty?
      if User.where(email: email).exists?
        errors.add(:email, :invalid)
      end
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end

class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :avatar

  validates :email, presence: true, uniqueness: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  # validates :username, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_username

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

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
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

  # Omniauth
  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      # binding.pry
      user.email = provider_data.info.email
      user.first_name = provider_data.info.first_name unless provider_data.info.first_name.empty?
      user.last_name = provider_data.info.last_name unless provider_data.info.last_name.empty?
      user.username = provider_data.info.email.split('@')[0].capitalize
      user.password = Devise.friendly_token[0, 20] #"XQ3UY34iCcKwL-73SLyL"
    end
  end
end

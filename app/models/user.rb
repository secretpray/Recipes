class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
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
    if provider.empty?
      if User.where(email: username).exists?
        binding.pry
        errors.add(:username, :invalid)
      end
    end
  end

  def uniq_email
    if provider.empty?
      if User.where(email: email).exists?
        binding.pry
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

  # Omniauth
  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      binding.pry
      email_row = provider_data.info.email.split('@')
      uniq_username = "#{email_row[0]}[#{provider_data.provider}-#{Time.now.to_i}]"
      uniq_email = "#{uniq_username}@#{email_row[1]}"
      user.username = uniq_username
      # user.email = provider_data.info.email
      user.email = uniq_email 
      if provider_data.provider == 'facebook'
        user.first_name = provider_data.info.name.split(' ')[0] unless provider_data.info.name.empty?
        user.last_name = provider_data.info.name.split(' ')[1] unless provider_data.info.name.empty?
      elsif  provider_data.provider != 'github'
        user.first_name = provider_data.info.first_name unless provider_data.info.first_name.empty?
        user.last_name = provider_data.info.last_name unless provider_data.info.last_name.empty?
      end
      user.password = Devise.friendly_token[0, 20] #"XQ3UY34iCcKwL-73SLyL"
    end
  end
end

class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :email, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :pwned_password

  enum role: %i(user moderator admin)
  
  after_initialize do
    if self.new_record?
      self.role ||= :user
    end
  end

  def username
    return email.split('@')[0].capitalize
  end
end

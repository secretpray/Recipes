class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :email, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :pwned_password
  
  # def in_favorites? (recipe)
  #   favorites = Favorite.where(user_id: self.id).order(created_at: :desc).pluck(:recipe_id)
  #   favorites.include?(recipe.id)
  #   # @favorites_list = Recipe.find(favorites)
  # end
end

class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :recipe_image
  has_many_attached :step_images

  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: :all_blank
  
  validates :title, :description, presence: true
  validate :image_type
  
  scope :by_add, -> { order(created_at: :desc) } # double
  scope :by_user, -> { order(user_id: :asc) }
  scope :favorited_by, -> (email) { joins(:favorites).where(favorites: { user: User.where(email: email)}) }

  def self.recent
    order('created_at desc')
  end

  def thumbnail input
    return self.step_images[input].variant(resize: '300x300!').processed
  end

  def image_type
    if recipe_image.present?
      errors.add(:recipe_image, 'needs to be a JPEG or PNG') unless recipe_image.content_type.in?(%('image/jpeg image/png'))
    end 
    
    if step_images.any?
      step_images.each do |image|
        errors.add(:step_images, 'needs to be a JPEG or PNG') unless image.content_type.in?(%('image/jpeg image/png'))
      end
    end
  end

  def in_favorite? user
    Favorite.where(recipe: self, user: user).any?
  end
end

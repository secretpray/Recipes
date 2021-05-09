class Recipe < ApplicationRecord
  extend FriendlyId
  
  belongs_to :user
  belongs_to :category
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  has_one_attached :recipe_image
  has_many_attached :step_images
  
  friendly_id :title, use: :slugged
  
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

  def to_s
    title    
  end

  def avg_score
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end

  def review_score_percentage
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f*100/5
    else
      0.0
    end
  end

  def self.best
    left_joins(:favorites).group(:id).order('COUNT(favorites) DESC')
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

  def all_tags
    self.tags.map(&:name).join(', ')
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  # Recipe.tagged_with('barbecue').count
  def self.tagged_with(name)
    Tag.find_by!(name: name).recipes
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

end

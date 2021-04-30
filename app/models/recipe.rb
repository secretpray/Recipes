class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_one_attached :recipe_image
  has_many_attached :step_images

  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: :all_blank
  
  validates :title, :description, presence: true
  
  scope :by_add, -> { order(created_at: :desc) }
  scope :by_user, -> { order(user_id: :asc) }
  # scope :by_best, -> { order(best: :desc, created_at: :asc) }

  def self.recent
    order('created_at desc')
  end

  def thumbnail input
    return self.step_images[input].variant(resize: '300x300').processed
  end
end

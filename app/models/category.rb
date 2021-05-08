class Category < ApplicationRecord    
  has_ancestry
  # has_ancestry cache_depth: true
  has_many :recipes, dependent: :destroy
  validates :name, presence: true

end

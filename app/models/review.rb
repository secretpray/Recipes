class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_rich_text :content
  
  validates :score, presence: true
end

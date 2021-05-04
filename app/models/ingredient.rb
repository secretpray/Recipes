class Ingredient < ApplicationRecord
  belongs_to :recipe
  has_rich_text :content
end

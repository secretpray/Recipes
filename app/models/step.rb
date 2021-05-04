class Step < ApplicationRecord
  belongs_to :recipe
  has_rich_text :method
end
